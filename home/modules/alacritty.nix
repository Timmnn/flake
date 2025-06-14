{ pkgs, ... }:

let modulePackages = with pkgs; [ alacritty ];
in {
  home.packages = modulePackages;

programs.alacritty = {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "FiraCode Nerd Font"; # or "Fira Code" if you're not using the Nerd Font version
      };
      size = 8.5;
    };
  };
};
}
