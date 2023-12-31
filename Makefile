PREFIX    ?= /usr
DIR_BIN   = $(PREFIX)/bin
DIR_MAN   = $(PREFIX)/share/man
DIR_MAN_1 = $(PREFIX)/share/man/man1

.DEFAULT: default
.PHONY: default format lint man install uninstall

default:
	@echo "Available tasks:"
	@echo ""
	@echo "    make format    =>   check syntax"
	@echo "    make lint      =>   statically analysis"
	@echo "    make man       =>   regenerate man pages after writing markdown"
	@echo "    make install   =>   locally install doom-utils"
	@echo ""

format:
	@echo "Running formatting task ..."
	@stylua src/
	@echo "Finished formatting task"

lint:
	@echo "Running linting task ..."
	@luacheck src/
	@echo "Finished linting task"

man:
	@echo "Running man pages task ..."
	@pandoc --standalone --to=man --output=man/wad.1 man/wad.1.md
	@pandoc --standalone --to=man --output=man/wad.5 man/wad.5.md
	@echo "Finished man pages task"

install:
	@echo "Running installation task ..."
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man1
	@mkdir -p $(DESTDIR)$(DIR_MAN)/man5
	@cp -p bin/wad   $(DESTDIR)$(PREFIX)/bin/wad
	@cp -p man/wad.1 $(DESTDIR)$(DIR_MAN)/man1/wad.1
	@cp -p man/wad.5 $(DESTDIR)$(DIR_MAN)/man5/wad.5
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/wad
	@echo "Finished installation task"

uninstall:
	@echo "Running uninstallation task ..."
	@rm -rf $(DESTDIR)$(PREFIX)/bin/wad
	@rm -rf $(DESTDIR)$(DIR_MAN)/man1/wad.1
	@rm -rf $(DESTDIR)$(DIR_MAN)/man5/wad.5
	@echo "Finished uninstallation task"

