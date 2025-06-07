# shell.nix for SDL3 development on NixOS
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Build tools
    git cmake gnumake gcc pkg-config
    
    # X11 libraries (using main packages to avoid .dev issues)
    xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXinerama
    xorg.libXcursor xorg.libXi xorg.libXfixes xorg.libXScrnSaver
    xorg.libXcomposite xorg.libXdamage xorg.libXtst xorg.libXxf86vm
    xorg.libXrender xorg.libICE xorg.libSM xorg.xorgproto
    
    # Wayland
    wayland wayland-protocols libxkbcommon wayland-scanner
    
    # Audio
    alsa-lib pulseaudio libsamplerate
    
    # Graphics
    libGL mesa vulkan-loader vulkan-headers libdrm
    
    # System
    systemd dbus
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config cmake
  ];

  shellHook = ''
    echo "SDL3 development environment loaded"
    
    # Set up environment variables for CMake
    export PKG_CONFIG_PATH="${pkgs.lib.makeSearchPathOutput "dev" "lib/pkgconfig" (with pkgs; [
      xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXinerama
      xorg.libXcursor xorg.libXi xorg.libXfixes xorg.libXcomposite
      xorg.libXdamage xorg.libXtst wayland libxkbcommon alsa-lib
      libGL systemd
    ])}:${pkgs.lib.makeSearchPath "lib/pkgconfig" (with pkgs; [
      xorg.libXScrnSaver xorg.libXxf86vm xorg.libXrender
      wayland-protocols pulseaudio libsamplerate mesa vulkan-headers
      libdrm dbus
    ])}:$PKG_CONFIG_PATH"
    
    # Set CMAKE_PREFIX_PATH
    export CMAKE_PREFIX_PATH="${pkgs.lib.concatStringsSep ":" (with pkgs; [
      xorg.libX11.dev or xorg.libX11
      xorg.libXext.dev or xorg.libXext
      xorg.libXrandr.dev or xorg.libXrandr
      wayland.dev or wayland
      libxkbcommon.dev or libxkbcommon
      alsa-lib.dev or alsa-lib
      libGL.dev or libGL
      systemd.dev or systemd
    ])}:$CMAKE_PREFIX_PATH"
    
    # Specific paths for SDL3's CMake configuration
    export X11_INCLUDE_DIR="${pkgs.xorg.libX11.dev or pkgs.xorg.libX11}/include"
    export X11_X11_INCLUDE_PATH="${pkgs.xorg.libX11.dev or pkgs.xorg.libX11}/include"
    export X11_X11_LIB="${pkgs.xorg.libX11}/lib/libX11.so"
    
    # Wayland paths
    export WAYLAND_INCLUDE_DIRS="${pkgs.wayland.dev or pkgs.wayland}/include"
    export WAYLAND_LIBRARIES="${pkgs.wayland}/lib"
    export WAYLAND_CLIENT_INCLUDE_DIR="${pkgs.wayland.dev or pkgs.wayland}/include"
    export WAYLAND_CLIENT_LIBRARIES="${pkgs.wayland}/lib/libwayland-client.so"
    export WAYLAND_SCANNER_EXECUTABLE="${pkgs.wayland-scanner}/bin/wayland-scanner"
    
    # XKB paths
    export XKB_INCLUDE_DIRS="${pkgs.libxkbcommon.dev or pkgs.libxkbcommon}/include"
    export XKB_LIBRARIES="${pkgs.libxkbcommon}/lib"
    
    # Debug information
    echo ""
    echo "Verifying key libraries:"
    pkg-config --exists x11 && echo "✓ X11 found" || echo "✗ X11 not found"
    pkg-config --exists wayland-client && echo "✓ Wayland client found" || echo "✗ Wayland client not found"
    pkg-config --exists xkbcommon && echo "✓ XKB common found" || echo "✗ XKB common not found"
    pkg-config --exists alsa && echo "✓ ALSA found" || echo "✗ ALSA not found"
    
    echo ""
    echo "Key paths:"
    echo "X11 headers: $X11_INCLUDE_DIR"
    echo "Wayland headers: $WAYLAND_INCLUDE_DIRS"
    echo ""
    echo "Ready to build SDL3!"
  '';
}
