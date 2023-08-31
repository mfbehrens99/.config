## Installed Packages
```
pacman -Qqe > ~/dotfiles/pacman.txt
```

```
pacman -Qqme > ~/dotfiles/yay.txt
```

### Delete unused dependencies
```
pacman -Rsn $(pacman -Qdtq)
```