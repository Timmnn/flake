{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package =
      pkgs.vscode; # Or `pkgs.vscodium` if you prefer the open-source build

    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      esbenp.prettier-vscode
      vscodevim.vim
      # Add more as needed
    ];

    userSettings = {
      "editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "onFocusChange";
      "workbench.colorTheme" = "Default Dark+";
      "workbench.sideBar.location" = "right";
      "editor.fontSize" = 11;
    };
  };
}
