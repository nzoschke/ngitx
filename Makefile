ROOT ?= $(shell pwd)

all: vendor/git vendor/nginx

clean:
	rm -rf $(ROOT)/src
	rm -rf $(ROOT)/vendor

vendor/fcgiwrap: src
	cd src/gnosek-fcgiwrap-2e301c8; 									\
		autoreconf																			\
		&& ./configure --prefix=$(ROOT)/vendor/fcgiwrap \
		&& make 																				\
		&& make install

vendor/git: src
	cd src/git-1.8.0; 												\
		./configure --prefix=$(ROOT)/vendor/git \
		&& make 																\
		&& make install

vendor/nginx: src
	cd src/ngx_openresty-1.2.4.5; 																												\
		./configure --prefix=$(ROOT)/vendor --with-luajit --with-pcre=$(ROOT)/src/pcre-8.31 \
		&& make 																																						\
		&& make install

src:
	mkdir -p src
	curl -s https://github.com/downloads/gnosek/fcgiwrap/fcgiwrap-1.0.3.tar.gz | tar xz -C src
	curl -s http://git-core.googlecode.com/files/git-1.8.0.tar.gz | tar xz -C src
	curl -s http://iweb.dl.sourceforge.net/project/pcre/pcre/8.31/pcre-8.31.tar.gz | tar xz -C src
	curl -s http://agentzh.org/misc/nginx/ngx_openresty-1.2.4.5.tar.gz | tar xz -C src
