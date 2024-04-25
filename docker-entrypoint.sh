#!/bin/sh

set -e

case "$1" in
  web)
    bundle exec rails db:prepare

    exec bundle exec puma -C config/puma.rb
  ;;

  *)
    exec $@
  ;;
esac
