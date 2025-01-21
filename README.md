# DOTFILES

## System maintenance

### Delete unused dependencies

```sh
sudo pacman -Rsn $(pacman -Qdtq)
sudo pacman -Syu
sudo pacman -Scc
```
