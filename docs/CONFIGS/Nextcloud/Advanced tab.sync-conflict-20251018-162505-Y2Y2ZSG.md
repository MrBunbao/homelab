# Handle WebDAV endpoints
location = /.well-known/carddav {
  return 301 $scheme://$host/remote.php/dav;
}
location = /.well-known/caldav {
  return 301 $scheme://$host/remote.php/dav;
}
location /.well-known/webfinger {
  return 301 $scheme://$host/index.php/.well-known/webfinger;
}
location /.well-known/nodeinfo {
  return 301 $scheme://$host/index.php/.well-known/nodeinfo;
}


# Proxy headers
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-Host $host;
