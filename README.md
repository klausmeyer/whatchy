# Whatchy

Rails app to track tv shows / series.

It gets it's data from [TheTVDB.com](https://www.thetvdb.com).

## Screenshots

All Shows

[![Screenshot - Explore View](docs/screenshot_explore_thumb.png)](docs/screenshot_explore.png)

Show Details

[![Screenshot - Show View](docs/screenshot_show_thumb.png)](docs/screenshot_show.png)

## Configuration

The following environment variables are available:

| Name                  | Mandatory |          Default          | Description                                                 |
| --------------------- | :-------: | :-----------------------: | ----------------------------------------------------------- |
| `BANNER_CACHE_HOST`   |     -     | https://cache.example.com | Host serving the images provided by [thetvdb.com][thetvdb]. |
| `DATABASE_URL`        |     x     |             -             | Database credentials in URL format.                         |
| `DOMAIN`              |     -     |             -             | Domain used for mail sender-address and links.              |
| `SMTP_ENABLED`        |     -     |             -             | Sending mails via SMTP (`true`/`false`).                    |
| `SMTP_SERVER`         |     -     |             -             | Hostname of the mail server.                                |
| `SMTP_PORT`           |     -     |            587            | Port of the mail server.                                    |
| `SMTP_USERNAME`       |     -     |             -             | Username for the mail server.                               |
| `SMTP_PASSWORD`       |     -     |             -             | Password for the mail server.                               |
| `RAILS_LOG_TO_STDOUT` |     -     |             -             | Log to process standard out (`true`/`false`).               |
| `THETVDB_APIKEY`      |     x     |             -             | API key for [thetvdb.com](https://thetvdb.com).             |

## Licence

The application is available as open source under the terms of the MIT License.
