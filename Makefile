pkg_name = yeti-lb

lintian_flag := $(if $(lintian),--lintian,--no-lintian)
debian_host_release != lsb_release -sc

#Logging functions
define info
        echo -e '\n\e[33m> msg \e[39m\n'
endef

define err
        echo -e '\n\e[31m> msg \e[39m\n'
endef

all:
	@echo "make all"

install:
	@$(info:msg=Installging)
	@echo "DESTDIR = '$(DESTDIR)'"	
	make -C src install

	@$(info:msg=install rsyslogd cfg file)
	@install -v -m0644 -D debian/$(pkg_name).rsyslog $(DESTDIR)/etc/rsyslog.d/$(pkg_name).conf


clean:
	make -C debian clean

.PHONY: package
package: chlog
	@$(info:msg=Building package)
	dpkg-buildpackage -us -uc -b


.PHONY: chlog
chlog: clean-chlog
ifeq "$(auto_chlog)" "no"
	@$(info:msg=Skipping changelog generation)
else
	@$(info:msg=Generating changelog Supply auto_chlog=no to skip.)
	@which changelog-gen || { $(err:msg=Failed to generate changelog. Did you install git-changelog package?) && false; }
	changelog-gen -p "$(pkg_name)" -d "$(debian_host_release)" -A "s/_/~/g" "s/-master/~master/" "s/-rc/~rc/"
endif


.PHONY: clean-chlog
clean-chlog:
ifneq "$(auto_chlog)" "no"
	@$(info:msg=Removing changelog)
	@rm -vf debian/changelog
endif

