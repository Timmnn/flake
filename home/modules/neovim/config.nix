{ config, pkgs, ... }:

{
  programs.neovim.enable = true;

  # Copy the whole nvim directory into $HOME/.config/nvim
  xdg.configFile."nvim".source = ./files;
}
