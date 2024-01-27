PREFIX   ?= /usr/local
DIR_BIN  = $(PREFIX)/bin
DIR_MAN  = $(PREFIX)/share/man
DIR_MAN1 = $(PREFIX)/share/man/man1
DIR_MAN5 = $(PREFIX)/share/man/man5

.DEFAULT: default
.PHONY: default format lint man install uninstall

default:
	@echo "-- Available Tasks\n"\
	"    make format     =>    syntax check\n"\
	"    make lint       =>    static analysis\n"\
	"    make man        =>    build man pages\n"\
	"    make install    =>    install doom-utils\n"\
	"\n"\
	"-- Development tools\n"\
	"    GNU Coreutils - 9.1\n"\
	"    GNU Make      - 4.3\n"\
	"    shellcheck    - 0.9.0\n"\
	"    shfmt         - 3.6.0\n"\
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
	@pandoc --standalone --to=man --output=man/wad.5 man/wad.5.md
	@pandoc --standalone --to=man --output=man/wadpath.1 man/wadpath.1.md
	@pandoc --standalone --to=man --output=man/wadcheck.1 man/wadcheck.1.md
	@echo "Build done"

install:
	@echo "Installing ..."
	@mkdir -p $(DESTDIR)$(DIR_BIN)
	@mkdir -p $(DESTDIR)$(DIR_MAN1)
	@mkdir -p $(DESTDIR)$(DIR_MAN5)
	@cp -p src/wadpath    $(DESTDIR)$(DIR_BIN)/wadpath
	@cp -p src/wadcheck   $(DESTDIR)$(DIR_BIN)/wadcheck
	@cp -p man/wadpath.1  $(DESTDIR)$(DIR_MAN1)/wadpath.1
	@cp -p man/wadcheck.1 $(DESTDIR)$(DIR_MAN1)/wadcheck.1
	@cp -p man/wad.5      $(DESTDIR)$(DIR_MAN5)/wad.5
	@chmod 755 $(DESTDIR)$(DIR_BIN)/wadcheck
	@chmod 755 $(DESTDIR)$(DIR_BIN)/wadpath
	@echo "Finished installing"

uninstall:
	@echo "Uninstalling ..."
	@rm -rf $(DESTDIR)$(DIR_BIN)/wadcheck
	@rm -rf $(DESTDIR)$(DIR_BIN)/wadpath
	@rm -rf $(DESTDIR)$(DIR_MAN1)/wad.1
	@rm -rf $(DESTDIR)$(DIR_MAN5)/wad.5
	@echo "Finished uninstalling"

