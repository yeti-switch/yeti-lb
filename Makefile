all:
	@echo "make all"

install:
	@echo "DESTDIR = '$(DESTDIR)'"	
	make -C src install

clean:
	make -C debian clean

package:
	dpkg-buildpackage -us -uc -b
