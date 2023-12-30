PREFIX ?= /usr
DIR_MAN ?= $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install doom-utils.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man1
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man5
	@install src/wad   --target-directory=$(DESTDIR)$(PREFIX)/bin
	@install man/wad.1 --target-directory=$(DESTDIR)$(DIR_MAN)/man1
	@install man/wad.1 --target-directory=$(DESTDIR)$(DIR_MAN)/man1
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/wad

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/wad
	@rm -rf $(DESTDIR)$(DIR_MAN)/man1/wad.1
	@rm -rf $(DESTDIR)$(DIR_MAN)/man1/wad.5

