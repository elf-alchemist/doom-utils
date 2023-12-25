PREFIX ?= /usr
DIR_MAN ?= $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install doom-utils.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man1
	@cp -p src/wad-finder $(DESTDIR)$(PREFIX)/bin/wad-finder
	@cp -p man/wad-finder.1 $(DESTDIR)$(DIR_MAN)/man1/wad-finder.1
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/wad-finder

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/wad-finder
	@rm -rf $(DESTDIR)$(DIR_MAN)/man1/wad-finder.1

