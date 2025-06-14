{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ./bootloader.nix
    #./x11.nix
    ./sound.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  home-manager.backupFileExtension = "home_manager_backup";
  networking.hostName = "timm-nixos";

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable CUPS (Common unix printing service) for printing
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # System packages
  environment.systemPackages = with pkgs; [

    # VPN
    openvpn3
    openvpn

    # Libmagic Dependencies
    libffi
    libffi.dev
    python312Packages.magic
    python312Packages.typecode-libmagic

    # Build tools
    gcc
    pkg-config

    # Formatters + LSPs
    nixfmt-classic
    stylua
    lua-language-server

    # CLI Tools
    eza
    unzip
    neofetch
    tldr
    file
    bat
    clang-tools
    ripgrep
    p7zip
    tree-sitter
    gnumake
    cmakeCurses

    # SDL3 runtime dependencies
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    xorg.libXfixes
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXtst

    # Audio
    alsa-lib
    pulseaudio
    pipewire

    # Video/Graphics
    libGL
    mesa
    vulkan-loader
    vulkan-headers

    # Input
    libudev-zero

    # Wayland
    wayland
    wayland-protocols
    libxkbcommon

    # Additional multimedia
    libsamplerate

    # Hyprland and related
    hyprland
    xdg-desktop-portal-hyprland
    swaylock
    swayidle
    wofi
    swww # Wallpaper switcher for Wayland
    bluez # Provides bluetoothctl for Bluetooth support
    ddcutil # Display control
    fd # Fast file finder for wallpaper scanning
    rofi-wayland # Optional: for application launcher

    nodejs
    typescript
    nodePackages.typescript-language-server


    gnome-control-center
    #network-manager-applet # For nm-applet, which is needed for VPN GUI
    #network-manager-openvpn # For OpenVPN support
    #network-manager-l2tp # For L2TP VPN support, if needed
    # Add other VPN plugins as needed (e.g., network-manager-pptp)

    ne

  ];

  # Enable fish shell
  programs.fish.enable = true;

  # System state version
  system.stateVersion = "25.05";

  services.dbus.enable = true;

  /*
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

 */ 


hardware.graphics = {
  enable = true;
  enable32Bit = true;
};




}
