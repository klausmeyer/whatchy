# Whatchy

Rails app to track tv shows / series.

It gets it's data from [thetvdb.com][thetvdb].

## Screenshots

All Shows

[![Screenshot - Explore View](docs/screenshot_explore_thumb.png)](docs/screenshot_explore.png)

Show Details

[![Screenshot - Show View](docs/screenshot_show_thumb.png)](docs/screenshot_show.png)

## Configuration

The following environment variables needs to be set:

* `BANNER_CACHE_HOST`: A host which is serving the images provided by [thetvdb.com][thetvdb]. Recommendation is to use a CDN like CloudFront to cache the images and not directly load them from [thetvdb.com][thetvdb].
* `THETVDB_APIKEY`: Credential for [thetvdb.com][thetvdb] in order to fetch data via their API.

## Deployment

By default the application is designed to run at [Heroku][heroku].

## Licence

The application is available as open source under the terms of the MIT License.

[thetvdb]: https://www.thetvdb.com
[heroku]: https://www.heroku.com
