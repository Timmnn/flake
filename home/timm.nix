{ config, pkgs, ... }:

{
  home.username = "timm";
  home.homeDirectory = "/home/timm";
  home.stateVersion = "23.11";

  imports = [
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/vscode.nix
  ];

  home.packages = [
    pkgs.neo-cowsay
  ];
}
