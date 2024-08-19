Caddy is a web server designed for modern web applications. Caddy is simple to configure and has automatic Let's Encrypt, so your websites are always secure by default.

In this guide you will learn how to:

* Install caddy
* Create a simply local website with caddy
* Proxy a web service behind caddy.
* Create caddy builds with `xcaddy`

# Install Caddy

This is an easy one, we are currently on an ubuntu image and we have the APT Package manager.

Here is a detailed guide on how to install it under ubuntu:

https://caddyserver.com/docs/install#debian-ubuntu-raspbian

Please also verify that caddy is `running` and active, and that firewall rules are made for http and https services with `UFW`, you might need to enable it first.

<details>
<summary>Solution</summary>

Install Caddy

```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
```{{exec}}

```bash
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```{{exec}}

Verify caddy is running

```bash
systemctl status caddy --no-pager
```{{exec}}

Enable and open ports for `http` and `https`

```bash
ufw enable
ufw allow http
ufw allow https
```
{{exec}}
</details>


Once you've completed the task you will be able to see a greeting page in:

{{TRAFFIC_HOST1_80}}
