{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Timm Tester";
    userEmail = "timm@example.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
