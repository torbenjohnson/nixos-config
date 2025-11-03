{ config, pkgs, ... }:

{
  home = {
    username = "tor";
    homeDirectory = "/home/tor";
    stateVersion = "25.05";

    sessionVariables = {
      EDITOR = "hx";
    };

    packages = with pkgs; [
      # Development Tools
      github-cli # GitHub CLI
      git-lfs # Git Large File Storage
      lazygit
      tokei

      # Nix Development
      nixfmt-rfc-style # Nix formatter
      nil # Nix LSP
      nix-tree
      nix-output-monitor

      # CLI Utilities - File Management
      ripgrep # Fast grep alternative
      fd # Fast find alternative
      bat # Cat with syntax highlighting
      eza # Modern ls replacement
      dust # Disk usage analyzer
      yazi # Terminal file manager
      zoxide # Smart cd command
      fzf # Fuzzy finder
      sd # sed alternative
      tree
      duf
      dua
      delta

      # CLI Utilities - Networking
      wget # File downloader
      curl # Transfer data with URLs
      iperf3 # Network bandwidth tester
      wavemon # Wireless network monitor
      mtr
      xh
      nmap
      wireshark
      tcpdump
      netcat

      # System Monitoring & Information
      btop # Modern resource monitor
      bottom # Another resource monitor
      procs
      s-tui # CPU stress tester
      powertop # Power consumption monitor
      dmidecode # System information
      ethtool # Ethernet tool
      nvme-cli # NVMe management
      usbutils # USB utilities
      acpi # ACPI information
      pciutils
      libva-utils # VA-API utilities

      # GPU Tools
      vulkan-tools

      # GUI System Monitoring
      mission-center # System monitor
      resources # GNOME resources monitor
      impala # System monitor

      # Media Applications
      spotify # Music streaming
      mpv # Media player
      ffmpeg # Media processing
      obs-studio # Recording/streaming
      yt-dlp
      imagemagick

      # Productivity Applications
      foliate # Ebook reader
      kdePackages.okular # PDF viewer
      libreoffice # Office suite

      # AI Assistants
      claude-code # Anthropic
      codex # OpenAI

      # Storage & File Management
      udisks2 # Disk management
      udiskie # Automounter
      zip # Compression
      unzip # Decompression
      rsync
      rclone

      # Miscellaneous
      gcr # GNOME crypto services
      xorg.xeyes # X11 test utility
      choose
      atuin
      stress-ng
      asciinema
      phoronix-test-suite
      fio
      binutils
      valgrind
      hyperfine
      perf
      dive
    ];
  };

  # XDG Base Directory Specification
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    # Link native config files (editable without rebuild)
    configFile = {
      "helix/config.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/helix/config.toml";
      "helix/languages.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/helix/languages.toml";
      "git/config".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/git/config";
      "Code/User/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/vscode/settings.json";
      "Code/User/keybindings.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/vscode/keybindings.json";
      "fish/config.fish".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/fish/config.fish";
      "fish/functions/theme_gruvbox.fish".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/fish/functions/theme_gruvbox.fish";
      "ghostty/config".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/config/ghostty/config";
    };
  };

  programs = {
    home-manager.enable = true;

    firefox.enable = true;
    chromium.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        log_format = "";
      };
    };

    git = {
      enable = true;
    };

    helix = {
      enable = true;
    };

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        # tombi-toml.tombi # Not currently available
        # rvben.rumdl
        ms-python.python
        ms-python.vscode-pylance
        jdinhlife.gruvbox
        golang.go
        redhat.vscode-yaml
        timonwong.shellcheck
        ms-vscode-remote.remote-ssh
      ];
    };

    zed-editor = {
      enable = true;
      extensions = [
        "basher"
        "dockerfile"
        "just-language-server"
        "justfile"
        "nix"
        "ruff"
        "toml"
      ];
    };

    ghostty.enable = true;

    nushell.enable = true;
  };

  # Services
  services = {
    gnome-keyring.enable = true;
  };
}
