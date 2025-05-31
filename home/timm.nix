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
    ./modules/neovim/config.nix
    ./modules/alacritty.nix
    #./modules/rust.nix
  ];

  home.packages = with pkgs; [
    neo-cowsay
    nixfmt
    _1password-gui
    gcc
    eza
    google-chrome
    python314
    nodejs_24
    unzip
    neofetch
    fishPlugins.tide
    meslo-lgs-nf
    tldr
    xclip
    rustc
    cargo
    rust-analyzer
    bat
    stylua
    lua-language-server
    ripgrep
    clippy
  ];
}
