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
      "editor.fontSize" = 11;
      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
      "files.autoSave" = "onFocusChange";
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.sideBar.location" = "right";
      "tree-sitter-vscode.languageConfigs" = [
        {
          lang = "xyz";
          parser = "/path/to/your/tree-sitter-xyz.wasm";
          highlights = "/path/to/your/highlights.scm";
          injections = "/path/to/your/injections.scm";
          semanticTokenTypeMappings = {
            constant = {
              targetTokenModifiers = [ "declaration" "readonly" ];
              targetTokenType = "variable";
            };
            module = {
              targetTokenType = "namespace";
            };
            "variable.member" = {
              targetTokenType = "property";
            };
            "variable.parameter" = {
              targetTokenType = "parameter";
            };
          };
        }
      ];
    };
  };
}
