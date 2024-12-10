FROM ruby:3.3.6-alpine

LABEL maintainer="Klaus Meyer <spam@klaus-meyer.net>"

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT=$SOURCE_COMMIT

ENV PORT=8080
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

EXPOSE $PORT

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk update \
 && apk add build-base zlib-dev tzdata git openssl-dev shared-mime-info postgresql-dev libc6-compat vips-dev \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /var/www/rails

COPY Gemfile Gemfile.lock /var/www/rails/
COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /var/www/rails/

RUN gem install bundler -v $(grep -A1 "BUNDLED WITH" Gemfile.lock | tail -n1 | tr -d "[:space:]") \
 && bundle config set without "development test" \
 && bundle install

ADD . /var/www/rails/

RUN SECRET_KEY_BASE=dummyvalue bundle exec rails assets:precompile

RUN addgroup -S rails && adduser -S rails -G rails -h /var/www/rails/ \
 && chown -R rails:rails /var/www/rails/ \
 && chown -R rails:rails /usr/local/bundle

USER rails

CMD ["web"]
