# style/kitty/EULR.nix

# Signalis Color Scheme. See also: style/helix/EULR.nix

let
  # === Theme Palette ==
  backgroundColor = "#0D0808"; # black-red

  # 0-7
  black = "#0A0C0E";
  red = "#A62D1A";
  green = "#277A4B";
  yellow = "#B38F1F";
  blue = "#223A5E";
  magenta = "#5D181A";
  cyan = "#578C96";
  white = "#D6CFC8";

  # 8-15
  bright_black = "#242629";
  bright_red = "#D6381C";
  bright_green = "#21B563";
  bright_yellow = "#D6AA1B";
  bright_blue = "#1B64BA";
  bright_magenta = "#802B2E";
  bright_cyan = "#2BA2B3";
  bright_white = "#F2F2F2";

in
{
  background_opacity = "0.90";
  background = backgroundColor;
  background_blur = 1;
  background_tint = "0.3";
  dynamic_background_opacity = "yes";

  foreground = bright_white;
  selection_background = magenta;
  selection_foreground = white;
  cursor = bright_cyan;
  cursor_text_color = black;
  url_color = bright_blue;

  color0 = black;
  color8 = bright_black;
  color1 = red;
  color9 = bright_red;
  color2 = green;
  color10 = bright_green;
  color3 = yellow;
  color11 = bright_yellow;
  color4 = blue;
  color12 = bright_blue;
  color5 = magenta;
  color13 = bright_magenta;
  color6 = cyan;
  color14 = bright_cyan;
  color7 = white;
  color15 = bright_white;
}
