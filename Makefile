pkg_name = yeti-lb

all:
	@echo "make all"

install:
	@echo "DESTDIR = '$(DESTDIR)'"	
	make -C src install

	@$(info:msg=install rsyslogd cfg file)
	@install -v -m0644 -D debian/$(pkg_name).rsyslog $(DESTDIR)/etc/rsyslog.d/$(pkg_name).conf


clean:
	make -C debian clean

package:
	dpkg-buildpackage -us -uc -b
