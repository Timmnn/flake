{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ./bootloader.nix
    ./x11.nix
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

  ];

  # Enable fish shell
  programs.fish.enable = true;

  # System state version
  system.stateVersion = "25.05";

}
