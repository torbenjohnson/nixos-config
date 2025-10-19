{ pkgs, lib, ... }:

{
  fonts = {
    # Enable font discovery and management
    fontDir.enable = true;

    # Font packages to install system-wide
    packages = with pkgs; [
      # Programming/Monospace fonts
      fira-code
      jetbrains-mono
      source-code-pro
      cascadia-code
      monaspace

      # Sans-serif fonts
      inter
      roboto
      open-sans
      liberation_ttf

      # Serif fonts
      source-serif
      liberation_ttf

      # System fonts
      dejavu_fonts
      freefont_ttf
      gyre-fonts # High-quality fonts based on URW fonts
      liberation_ttf
      unifont # Wide Unicode coverage

      # Icon fonts
      font-awesome
      material-design-icons

      # Asian language support
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      # Additional Unicode coverage
      symbola # Symbols and emojis
    ];

    # Font configuration
    fontconfig = {
      enable = true;

      # Default fonts for different categories
      defaultFonts = {
        serif = [
          "Source Serif"
          "DejaVu Serif"
          "Noto Serif"
        ];
        sansSerif = [
          "Inter"
          "Roboto"
          "DejaVu Sans"
          "Noto Sans"
        ];
        monospace = [
          "Monaspace Neon"
          "FiraCode Nerd Font"
          "JetBrains Mono"
          "Source Code Pro"
          "DejaVu Sans Mono"
        ];
        emoji = [
          "Noto Color Emoji"
          "Font Awesome 6 Free"
        ];
      };

      # Improve font rendering
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = lib.mkDefault "rgb";
        lcdfilter = lib.mkDefault "default";
      };
    };
  };
}
