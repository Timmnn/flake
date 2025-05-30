{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      gs = "git status";
    };
  };
}