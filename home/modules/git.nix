{ ... }: {
  programs.git = {
    enable = true;
    userName = "Timm Nicolaizik";
    userEmail = "timmmmnn@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };
}
