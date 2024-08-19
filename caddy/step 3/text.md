# Reverse proxy a local resource

We will be reverse proxying a simple python application hosted locally.

Let's get it setup.

Create a simple directory to work under and a new index.html to serve with `python3 -m http.server`

```
mkdir /root/webfiles
echo "Another new page serve with python3" > /root/webfiles/index.html
```{{exec}}

Move into the direcotry and create a simple server on the background on port 9000

```
cd /root/webfiles
python3 -m http.server 8080 &
```{{exec}}


Let's edit our Caddyfile once again to apply changes.

First we will comment the line `root * /usr/share/caddy/` by appending a `#`

We will now enable the reverse proxy by uncommenting the line `reverse_proxy localhost:8080` by removing `#`.


Your caddy file should look a little bit like this:

```
# The Caddyfile is an easy way to configure your Caddy web server.
#
# Unless the file starts with a global options block, the first
# uncommented line is always the address of your site.
#
# To use your own domain name (with automatic HTTPS), first make
# sure your domain's A/AAAA DNS records are properly pointed to
# this machine's public IP, then replace ":80" below with your
# domain name.

web.in.internal {
  tls internal
  # Set this path to your site's directory.
  # root * /usr/share/caddy/

  # Enable the static file server.
  file_server

  # Another common task is to set up a reverse proxy:
  reverse_proxy localhost:8080

  # Or serve a PHP site through php-fpm:
  # php_fastcgi localhost:9000
}

# Refer to the Caddy docs for more information:
# https://caddyserver.com/docs/caddyfile
```

Reload your caddy configuration, as this does not need a restart of the service.

```bash
caddy reload  --config /etc/caddy/Caddyfile
```{{exec}}

Query our webserver again and we should see a different result than previously.

```bash
curl https://web.in.internal
```{{exec}}

You'll also notice that the output from the background server (python) is also viewed on the foreground. `127.0.0.1 - - [19/Aug/2024 16:34:23] "GET / HTTP/1.1" 200 -` which indicates that it sucessfully received a request.