ROOT ?= $(shell pwd)

all: vendor/git vendor/httpd

clean:
	rm -rf $(ROOT)/src
	rm -rf $(ROOT)/vendor

vendor/git: src
	cd src/git-1.8.1.4; 																				\
		./configure --prefix=$(ROOT)/vendor/git --without-tcltk 	\
		&& make -i																								\
		&& make -i install

vendor/httpd: src
	cd src/httpd-2.2.24;												\
		./configure --prefix=$(ROOT)/vendor/httpd \
		&& make 																	\
		&& make install

src:
	mkdir -p src
	curl -s http://apache.mirrors.pair.com/httpd/httpd-2.2.24.tar.gz | tar xz -C src
	curl -s http://git-core.googlecode.com/files/git-1.8.1.4.tar.gz | tar xz -C src
