ROOT ?= $(shell pwd)

all: vendor/git vendor/http vendor/nginx

clean:
	rm -rf $(ROOT)/src
	rm -rf $(ROOT)/vendor

vendor/git: src
	cd src/git-1.8.0; 												\
		./configure --prefix=$(ROOT)/vendor/git \
		&& make 																\
		&& make install

vendor/httpd: src
	true

vendor/nginx: src
	cd src/ngx_openresty-1.2.4.5; 																												\
		./configure --prefix=$(ROOT)/vendor --with-luajit --with-pcre=$(ROOT)/src/pcre-8.31 \
		&& make 																																						\
		&& make install

src:
	mkdir -p src
	curl -s http://apache.mirrors.hoobly.com//httpd/httpd-2.4.3.tar.gz | tar xz -C src
	curl -s http://git-core.googlecode.com/files/git-1.8.0.tar.gz | tar xz -C src
	curl -s http://iweb.dl.sourceforge.net/project/pcre/pcre/8.31/pcre-8.31.tar.gz | tar xz -C src
	curl -s http://agentzh.org/misc/nginx/ngx_openresty-1.2.4.5.tar.gz | tar xz -C src
