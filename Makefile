PREFIX    ?= /usr
DIR_BIN   = $(PREFIX)/bin
DIR_MAN   = $(PREFIX)/share/man
DIR_MAN_1 = $(PREFIX)/share/man/man1

.DEFAULT: default
.PHONY: default format lint man install uninstall

default:
	@echo "Available tasks:\n" \
	"\n" \
	"    make tools      =>    list necessary tools\n" \
	"    make format     =>    syntax check\n" \
	"    make lint       =>    static analysis\n" \
	"    make man        =>    build man pages\n" \
	"    make install    =>    install doom-utils\n" \

tools:
	@echo \
	"Tools required, minimum versions:\n" \
	"\n" \
	"    GNU Coreutils - 9.1\n" \
	"    GNU Make      - 4.3\n" \
	"    shellcheck    - 0.9.0\n" \
	"    shfmt         - 3.6.0\n" \
	"    pandoc        - 2.17.1.1\n"

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

