# ngitx

Experiments with Apache and CGI git-http-backend behind an nginx load balancing 
proxy.

The simplest nginx config uses the ngx_http_consistent_hash module to select a
backend.

A more powerful nginx config uses the lua-nginx-module to program arbitrarily
complex methods of selecting a backend. See the `location ~ ^/lua` section of 
bin/nginx for one experiment. With ngx.location.capture or lua-resty-redis,
backends can be selected by querying a remote resource, all in a non-blocking 
manner.

## Darwin Quickstart

Relies on system `/usr/sbin/httpd`

```sh
$ make
$ foreman start

$ bin/git-init /tmp/foo.git

$ git push http://localhost:5000/foo.git master
remote: Simulating build.....
remote: Randomly failing. Try again.
To http://localhost:5000/foo.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'http://localhost:5000/foo.git'

$ git push http://localhost:5000/foo.git master
remote: Simulating build.....
To http://localhost:5000/foo.git
 * [new branch]      master -> master
```