{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package =
      pkgs.vscode; # Or `pkgs.vscodium` if you prefer the open-source build

    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      bbenoist.nix
      brettm12345.nixfmt-vscode
    ];

    userSettings = {
      "editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "onFocusChange";
      "workbench.sideBar.location" = "right";
      "editor.fontSize" = 11;
      "workbench.colorTheme" = "Catppuccin Macchiato";
    };
  };
}
