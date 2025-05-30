{ config, pkgs, ... }:

{
  home.username = "timm";
  home.homeDirectory = "/home/timm";
  home.stateVersion = "24.05";

  imports = [
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
  ];

  home.packages = [
    pkgs.neo-cowsay
    pkgs.nixfmt
  ];
}
