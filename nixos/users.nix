{ pkgs, ... }: {
  users.users.timm = {
    isNormalUser = true;
    description = "Timm Nicolaizik";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
}
