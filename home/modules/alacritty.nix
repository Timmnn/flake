{ pkgs, ... }:

let modulePackages = with pkgs; [ alacritty ];
in {
  home.packages = modulePackages;

  programs.alacritty = {
    enable = true;
    settings = { font = { size = 8.5; }; };
  };
}
