# ngitx

Experiments with Apache and CGI git-http-backend behind an nginx consistent 
hashing load balancing proxy.

Nginx is built via ngx_openresty, where the lua-nginx-module opens up very
flexible methods of proxying to a specific Apache backend. See the 
`location ~ ^/lua` section of bin/nginx for one experiment.

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