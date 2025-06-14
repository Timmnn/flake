{ config, pkgs, ... }:
{
  xdg.configFile."eww".source = ./files;
}
