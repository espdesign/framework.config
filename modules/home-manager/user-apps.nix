{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Remote Desktop
    rustdesk-flutter

    # Productivity
    obsidian
    libreoffice
    onlyoffice-desktopeditors
    typst
    stirling-pdf

    # Communication
    vesktop
    slack
    signal-desktop

    # Media
    spotify
    mpv
    bottles
    qbittorrent

    # GNOME Utilities
    dconf-editor
    gnome-shell-extensions

    # Development
    zed-editor-fhs
    gemini-cli

    # --- YOUR CUSTOM PACKAGES ---
    # This grabs 'my-hello' from your ./pkgs/default.nix
    # inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.my-hello
  ];

  # EasyEffects Service (If you just want it installed)
  services.easyeffects.enable = true;
}
