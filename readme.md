<# LotusXSS

<div align="center">
  <img src="https://i.ibb.co/GsC7ddZ/077f441c-b58d-4b9c-9d13-72281930d24e.jpg" alt="LotusXSS">
</div>

## 🌟 Features

- **User-Friendly Dashboard:** Settings, statistics, payloads, and report management.
- **Persistent XSS Sessions:** Active as long as the browser is running, with reverse proxy support.
- **Access Control:** Unlimited user support with custom permissions for payloads and reports.
- **Real-Time Alerts:** Receive notifications via email, Telegram, Slack, Discord, or custom callbacks.
- **Customization:** Tailor-made JavaScript payloads and unique payload links.
- **Advanced Filtering:** Options to extract additional pages, apply block/whitelist filters.
- **Two-Factor Authentication:** Enhance security for user logins.
- **Comprehensive Data Collection:** Including URL, IP address, referer, User-Agent, cookies, storage data, full HTML DOM, page origin, execution time, payload URL, page screenshots, and more.

## 📋 Requirements

- **Server Compatibility:** PHP 7.1 or higher.
||||||| merged common ancestors

=======
<div align="center">
  <img src="https://i.ibb.co/GsC7ddZ/077f441c-b58d-4b9c-9d13-72281930d24e.jpg" alt="LotusXSS">
</div>
>>>>>>> master

## 🌟 Features
>>>>>>> master

- **User-Friendly Dashboard:** Settings, statistics, payloads, and report management.
- **Persistent XSS Sessions:** Active as long as the browser is running, with reverse proxy support.
- **Access Control:** Unlimited user support with custom permissions for payloads and reports.
- **Real-Time Alerts:** Receive notifications via email, Telegram, Slack, Discord, or custom callbacks.
- **Customization:** Tailor-made JavaScript payloads and unique payload links.
- **Advanced Filtering:** Options to extract additional pages, apply block/whitelist filters.
- **Two-Factor Authentication:** Enhance security for user logins.
- **Comprehensive Data Collection:** Including URL, IP address, referer, User-Agent, cookies, storage data, full HTML DOM, page origin, execution time, payload URL, page screenshots, and more.

## 📋 Requirements

- **Server Compatibility:** PHP 7.1 or higher.
- **Domain Name:** Short domain recommended ([shortboost](https://github.com/ssl/shortboost)).
- **SSL Certificate:** For HTTPS websites (Cloudflare or Let's Encrypt for free SSL).

## 🧪 Tested Environments
>>>>>>> master

- Kali Linux 2023.3
- Ubuntu 22.04 
- Ubuntu 23.10
- Mint 21.2
- Debian 12


## ⚙️ Installation

**Note:** The installation scripts are compatible with Linux distributions that use the `apt` package manager and `systemd` for system and service management.

### Apache2 Setup

1. **Download:** `install_ap2.sh`.
2. **Prepare:** `chmod +x install_ap2.sh`.
3. **Execute:** `./install_ap2.sh`.

### Nginx Setup

1. **Download:** `install_ng.sh`.
2. **Prepare:** `chmod +x install_ng.sh`.
3. **Execute:** `./install_ng.sh`.

### Docker Installation

**Automatic:**
1. **Download:** `install_dk.sh`.
2. **Prepare:** `chmod +x install_dk.sh`.
3. **Execute:** `./install_dk.sh`.

**Manual:**
- Clone the repository into `/var/www/html/`.
- Rename `.env.example` to `.env` and set a secure password.
- Update `msmtprc` for email alerts.
- Run `docker-compose build && docker-compose up -d`.
- Initialize account setup at `/manage/install`.
>>>>>>> master
