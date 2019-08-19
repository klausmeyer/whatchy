# Whatchy

Rails app to track tv shows / series.

It gets it's data from [thetvdb.com][thetvdb].

## Configuration

The following environment variables needs to be set:

* `BANNER_CACHE_HOST`: A host which is serving the images provided by [thetvdb.com][thetvdb]. Recommendation is to use a CDN like CloudFront to cache the images and not directly load them from [thetvdb.com][thetvdb].
* `THETVDB_APIKEY`: Credential for [thetvdb.com][thetvdb] in order to fetch data via their API.

## Deployment

By default the application is designed to run at [Heroku][heroku].

[thetvdb]: https://www.thetvdb.com
[heroku]: https://www.heroku.com

## Licence

The application is available as open source under the terms of the MIT License.
