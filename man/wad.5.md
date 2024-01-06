% WAD(5) POSIX | Wad file format

NAME
====

wad - Game data file format for Doom engine games.

DESCRIPTION
===========

**wad** files are the primary means of storing game assets for Doom
engine (a.k.a idTech 1) games. Individual files are known as "lumps",
these include textures, flats, sprites, midi, etc.

All wad file start with the binary magic numbers "IWAD" or "PWAD",
depending on whether they are "Internal wads", the base game, or "Patch
wads", essentially mods that override previous content or add new
content on top of the previous one.

CREDITS
=======

DoomWiki \<https://doomwiki.com/wiki/WAD\>

SEE ALSO
========

wad(1)
