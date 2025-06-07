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
    # Fish Shell
    fish
    fishPlugins.tide

    # IDE
    code-cursor
    jetbrains.pycharm-professional


    # Desktop Apps
    _1password-gui
    google-chrome
    vlc
    discord
    vesktop

    # Programming Langugages
    python312Full
    nodejs_24
    uv
    rustc
    cargo
    rust-analyzer
    clippy
    typescript

    # Fonts
    meslo-lgs-nf

    # Gnome Packages
    xclip
  ];
}

