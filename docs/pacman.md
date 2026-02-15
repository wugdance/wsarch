# Remove pacman package

```bash
sudo pacman -Rcns <package>
```
-R: remove
-c: cascade (check what will get removed)
-n: no save (when I remove something I really want it gone)
-s: remove dependencies (mostly for cleanup)

If there are potential problems with -c, cancel and do

```bash
sudo pacman -Runs <package>
```

-u: avoid removing packages if other packages depend on it.


# Search for packages

```bash
# Search for all python-related packages
pacman -Ss python

# More specific search for python versions
pacman -Ss '^python[0-9]'
```
