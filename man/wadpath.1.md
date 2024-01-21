% wad(1) POSIX | Doom utility suite
% Guilherme M Miranda \<alchemist.software@proton.me\>
% 2024-01-21

# NAME

**wadpath** \- Retrieve WAD installation paths.

# SYNOPSIS

**wadpath [-m]**

**wadpath [-h]**

**wadpath [-v]**

# DESCRIPTION

**wadpath**
Returns the default DOOMWADDIR and DOOMWADPATH environment variables, to use in your favorite source port.
To use proprely, add the following line to your '.bashrc' or equivalent.

```bash
eval "$(wadpath)"
```

**-m, manual**
Opens manual pages directly from **wadpath**, then exits.

**-h, help**
Shows basic help information, links for further help, then exits.

**-v, version**
Shows version information, then exits.

# SEE ALSO

wadcheck(1) wad(5)

