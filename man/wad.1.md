% wad(1) POSIX | Doom utility suite
% Guilherme M Miranda \<alchemist.software@proton.me\>
% 2024-01-08

# NAME

**wad** \- General purpose tool to work with WAD files.

# SYNOPSIS

**wad**

**wad find**

**wad path**

**wad help**

**wad version**

# DESCRIPTION

**find**
Finds the location of your WAD files and sorts them in your local data directory "$XDG_DATA_HOME/doom-utils".

**path**
Returns the default $DOOMWADDIR and $DOOMWADPATH environment variables, run it as the following:

```bash
bash-5.2$ eval "$(wad path)"
```

**help**
Shows basic help info, links for further help and copyright notice, then exits.

**version**
Shows version info and copyright notice, then exits.

# SEE ALSO

wad(5)

