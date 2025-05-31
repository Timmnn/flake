{ pkgs, ... }:

{

  programs.fish = {
    enable = true;
    shellAliases = {
      la = "eza -la";
      ls = "eza";
      cl = "clear";
    };
    shellInit = ''
      set -g tide_prompt_style Rainbow
      set -g tide_prompt_colors True
      set -g tide_show_time true
      set -g tide_time_format 24-hour
      set -g tide_rainbow_prompt_separators Slanted
      set -g tide_powerline_prompt_heads Sharp
      set -g tide_powerline_prompt_tails Flat
      set -g tide_powerline_prompt_style One-line
      set -g tide_prompt_spacing Sparse
      set -g tide_icons Many
      set -g tide_transient_prompt No
    '';
  };

}
