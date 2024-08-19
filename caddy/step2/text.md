# Creating a simple Caddyfile

You now have an installation of caddy running and ready to server web servers and proxy other resouces internally.

Let's get to work!

What are Caddyfiles?

The Caddyfile is a convenient Caddy configuration format for humans. It is most people's favorite way to use Caddy because it is easy to write, easy to understand, and expressive enough for most use cases.

A simple static webserver is by default deployed with Caddy.

`/etc/caddy/Caddyfile` Specifies how the static webserver is deployed.

`/usr/share/caddy/index.html` is where the default greeting page file is located.


```bash
cp /usr/share/caddy/index.html /usr/share/caddy/index-back.html
echo "New page!" > /usr/share/caddy/index.html
```{{exec}}

With caddy you can create a local certificate with the `tls` directive by simply passing internal.

>Please note that you might need to use a different parameter for TLS if you are trying to use an external domain. (ex; cloudflare, duckdns)

Please edit your `/etc/caddy/Caddyfile` like the following:

```
web.in.internal {
  tls internal
  # Set this path to your site's directory.
  root * /usr/share/caddy/

  # Enable the static file server.
  file_server

  # Another common task is to set up a reverse proxy:
  # reverse_proxy localhost:8080

  # Or serve a PHP site through php-fpm:
  # php_fastcgi localhost:9000
}
```

Trusting caddy to grant permissions to create a ceritficate, and restarting the caddy service.

```bash
caddy trust
```{{exec}}

```bash
systemctl restart caddy
```{{exec}}

Please note you will have to create an entry under `/etc/hosts` due to our lab constraints:
Typically, you would use your own domain name instead of `web.in.internal`.

```bash
echo "127.0.0.2  web.in.internal" >> /etc/hosts
```{{exec}}

Verify the certificate and experiration dates

```bash
echo | openssl s_client -connect web.in.internal:443
echo | openssl s_client -connect web.in.internal:443 2>/dev/null | openssl x509 -noout -dates
```{{exec}}

Verify the static webserver is correctly being serve via https

```bash
curl https://web.in.internal
```{{exec}}

In the next step we will be using the reverse_proxy directive to reverse_proxy internal resources.