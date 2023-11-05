<p align="center">
  <img src="https://i.ibb.co/zQzDQgP/lotus-v1-1.png"><br>
</p>

## Features
* Easy to use dashboard with settings, statistics, payloads, view/share/search reports
* :new: Persistent XSS sessions with reverse proxy aslong as the browser is active
* Unlimited users with permissions to personal payloads & their reports
* Instant alerts via mail, Telegram, Slack, Discord or custom callback URL
* Custom javascript payloads
* Custom payload links to distinguish insert points
* Extract additional pages, block, whitelist and other filters
* Secure your login with Two-factor (2FA)
* The following information can be collected on a vulnerable page:
    * The URL of the page
    * IP Address
    * Any page referer (or share referer)
    * The User-Agent
    * All Non-HTTP-Only Cookies
    * All Locale Storage
    * All Session Storage
    * Full HTML DOM source of the page
    * Page origin
    * Time of execution
    * Payload URL
    * Screenshot of the page
    * Extract additional defined pages
* much much more

## Required
* Server or webhosting with PHP 7.1 or up
* Domain name (consider a short one or check out [shortboost](https://github.com/ssl/shortboost))
* SSL Certificate to test on https websites (consider Cloudflare or Let's Encrypt for a free SSL)

## Installation
lotusXSS is easy to install with Apache, NGINX or Docker

visit the [wiki](https://github.com/ssl/ezXSS/wiki) for installation instructions.
