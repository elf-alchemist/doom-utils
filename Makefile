PREFIX    ?= /usr
DIR_BIN   = $(PREFIX)/bin
DIR_MAN   = $(PREFIX)/share/man
DIR_MAN_1 = $(PREFIX)/share/man/man1

.DEFAULT: default
.PHONY: default format lint man install uninstall

default:
	@echo "Available tasks:"
	@echo ""
	@echo "    make format     =>    syntax check"
	@echo "    make lint       =>    static analysis"
	@echo "    make man        =>    build man pages after writing markdown"
	@echo "    make install    =>    install doom-utils"
	@echo ""

format:
	@echo "Formatting ..."
	@shfmt --write src/
	@echo "Formatting done"

lint:
	@echo "Linting ..."
	@shellcheck --color=auto --enable=all --shell=bash src/*
	@echo "Linting done"

man:
	@echo "Building man pages ..."
	@pandoc --standalone --to=man --output=man/wad.1 man/wad.1.md
	@pandoc --standalone --to=man --output=man/wad.5 man/wad.5.md
	@echo "Build done"

install:
	@echo "Installing ..."
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man1
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man5
	@cp -p src/wad   $(DESTDIR)$(PREFIX)/bin/wad
	@cp -p man/wad.1 $(DESTDIR)$(DIR_MAN)/man1/wad.1
	@cp -p man/wad.5 $(DESTDIR)$(DIR_MAN)/man5/wad.5
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/wad
	@echo "Finished installing"

uninstall:
	@echo "Uninstalling ..."
	@rm -rf $(DESTDIR)$(PREFIX)/bin/wad
	@rm -rf $(DESTDIR)$(DIR_MAN)/man1/wad.1
	@rm -rf $(DESTDIR)$(DIR_MAN)/man5/wad.5
	@echo "Finished uninstalling"

