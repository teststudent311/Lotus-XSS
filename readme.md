# LotusXSS

<p align="center">
  <img src="https://i.ibb.co/GsC7ddZ/077f441c-b58d-4b9c-9d13-72281930d24e.jpg"><br>
</p>

## Features

- Easy to use dashboard with settings, statistics, payloads, view/share/search reports.
- Persistent XSS sessions with reverse proxy as long as the browser is active.
- Unlimited users with permissions to personal payloads & their reports.
- Instant alerts via mail, Telegram, Slack, Discord, or custom callback URL.
- Custom JavaScript payloads.
- Custom payload links to distinguish insert points.
- Extract additional pages, block, whitelist, and other filters.
- Secure your login with Two-factor authentication.
- The following information can be collected on a vulnerable page:
    - The URL of the page.
    - IP Address.
    - Any page referer (or share referer).
    - The User-Agent.
    - All Non-HTTP-Only Cookies.
    - All Locale Storage.
    - All Session Storage.
    - Full HTML DOM source of the page.
    - Page origin.
    - Time of execution.
    - Payload URL.
    - Screenshot of the page.
    - Extract additional defined pages.
- More.

## Required

- Server or web hosting with PHP 7.1 or up.
- Domain name (consider a short one or check out [shortboost](https://github.com/ssl/shortboost)).
- SSL Certificate to test on HTTPS websites (You can use Cloudflare or Let's Encrypt for a free SSL).

## Tested

On Kali Linux 2023.3
On Ubuntu 22.04
On Ubuntu 23.10
On Mint 21.2

## Installation

### Install with Apache2

1. Download `install_ap2.sh`.
2. Make executable: `chmod +x install_ap2.sh`.
3. Execute: `./install_ap2.sh`.

### Install with Nginx

1. Download `install_ng.sh`.
2. Make executable: `chmod +x install_ng.sh`.
3. Execute: `./install_ng.sh`.

### Install with Docker

**Auto:**
1. Download `install_dk.sh`.
2. Make executable: `chmod +x install_dk.sh`.
3. Execute: `./install_dk.sh`.

**Manual:**
- Clone the repository and put the files in the document root (/var/www/html/).
- Rename `.env.example` to `.env` and update it with a secure randomly generated password.
- If you want mail alerts, update SMTP info in `msmtprc`.
- Run `docker-compose build && docker-compose up -d`.
- Visit `/manage/install` in your browser and setup your account.
