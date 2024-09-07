# Creating snippets and importing

Snippets are a way to programatically repeat something, let's say we want to create multiple webservers with the same configurations without repeating the same actions over and over.

```
web.in.internal {
    header {
        header_up Strict-Transport-Security "max-age=31536000;"
        header_up X-XSS-Protection "1; mode=block"
        header_up X-Frame-Options "SAMEORIGIN"
        header_up X-Robots-Tag "noindex, nofollow"
        header_up X-Content-Type-Options "nosniff"
        header_up -Server
        header_up -X-Powered-By
        header_up Referrer-Policy "same-origin"
    }
}
web1.in.internal {
    header {
        header_up Strict-Transport-Security "max-age=31536000;"
        header_up X-XSS-Protection "1; mode=block"
        header_up X-Frame-Options "SAMEORIGIN"
        header_up X-Robots-Tag "noindex, nofollow"
        header_up X-Content-Type-Options "nosniff"
        header_up -Server
        header_up -X-Powered-By
        header_up Referrer-Policy "same-origin"
    }
}
web2.in.internal {
    header {
        header_up Strict-Transport-Security "max-age=31536000;"
        header_up X-XSS-Protection "1; mode=block"
        header_up X-Frame-Options "SAMEORIGIN"
        header_up X-Robots-Tag "noindex, nofollow"
        header_up X-Content-Type-Options "nosniff"
        header_up -Server
        header_up -X-Powered-By
        header_up Referrer-Policy "same-origin"
    }
}
web3.in.internal {
    header {
        header_up Strict-Transport-Security "max-age=31536000;"
        header_up X-XSS-Protection "1; mode=block"
        header_up X-Frame-Options "SAMEORIGIN"
        header_up X-Robots-Tag "noindex, nofollow"
        header_up X-Content-Type-Options "nosniff"
        header_up -Server
        header_up -X-Powered-By
        header_up Referrer-Policy "same-origin"
    }
}
```

This is inneficient.

Instead we can create a snippet, import the snippet file and use the snippet to create these servers.

Let's create a snippet folder and a new snippet file:

```bash
mkdir -p /etc/caddy/snippets
cat << EOF > /etc/caddy/snippets/headers
(default_headers) { 
    header_up Strict-Transport-Security "max-age=31536000;"
    header_up X-XSS-Protection "1; mode=block"
    header_up X-Frame-Options "SAMEORIGIN"
    header_up X-Robots-Tag "noindex, nofollow"
    header_up X-Content-Type-Options "nosniff"
    header_up -Server
    header_up -X-Powered-By
    header_up Referrer-Policy "same-origin"
}
EOF
```{{exec}}

What's going on?

(default_headers) is the name of our snippet. `import /etc/caddy/snippets/headers`
everytime we call default_headers in our Caddyfile we will source this exact same code to our config. Be aware that you still need to be mindful of the structure of the caddyfile.

Let's make modifications to our caddyfile to reflect this.

```
import /etc/caddy/snippets/headers

web.in.internal {
  tls internal
  header {
    default_headers
  }
  # Set this path to your site's directory.
  # root * /usr/share/caddy/

  # Enable the static file server.
  # file_server

  # Another common task is to set up a reverse proxy:
  reverse_proxy localhost:8080

  # Or serve a PHP site through php-fpm:
  # php_fastcgi localhost:9000
}

web2.in.internal {
  tls internal
  header {
    default_headers
  }
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

Now we have sucessfully modify the headers for our domains, without having to repeat the same process across multiple srvs.
