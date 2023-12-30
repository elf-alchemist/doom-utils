PREFIX ?= /usr
DIR_MAN ?= $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install doom-utils.

build:
	@echo "Building man pages"
	@pandoc --standalone --to=man --output=man/wad.1 docs/wad.1.md
	@pandoc --standalone --to=man --output=man/wad.5 docs/wad.5.md
	@echo "Successfully built man pages"

install: build
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

