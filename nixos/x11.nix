{ pkgs, ... }: {
  # Keymap
  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };

  # Enable XDG portals for Hyprland
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  # Enable X server and GDM
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

}
