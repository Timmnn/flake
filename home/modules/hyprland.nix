{ config, pkgs, lib, ... }:

let
  colors = import ../../colors.nix;

  activeBorder = colors.hexToRgba colors.primary;
  inactiveBorder = colors.hexToRgba (colors.darken colors.primary 20);
in {

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x360, auto"
        "DP-3, 2560x1440@144, 1920x0, auto"
        "DP-2, 2560x1440@59.94, 4480x0, auto"
      ];

      env =
        [ "XCURSOR_SIZE,18" "HYPRCURSOR_SIZE,18" "QT_QPA_PLATFORMTHEME,qt6ct" ];

      exec-once = [
        "waybar"
        "waypaper --restore"
        "gsettings set org.gnome.desktop.interface gtk-theme 'YOUR_DARK_GTK3_THEME'"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
        "caelestia shell"
      ];

      input = {
        kb_layout = "eu";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      gestures.workspace_swipe = false;

      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        "col.active_border" = activeBorder;
        "col.inactive_border" = activeBorder;

      };

      decoration = {
        rounding = 5;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      bind = [
        "SUPER, Q, exec, ghostty"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, E, exec, dolphin"
        "SUPER, R, exec, wofi --show drun"
        "SUPER, P, pseudo"
        "SUPER, J, togglesplit"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        "SUPER, space, exec, fuzzel"
      ];

      bindm =
        [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
