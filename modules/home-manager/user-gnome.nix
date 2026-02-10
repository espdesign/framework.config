{
  config,
  pkgs,
  ...
}:
{

  # 1. Create the custom "Clean" Thunderbird launcher
    xdg.desktopEntries.thunderbird-clean = {
      name = "Thunderbird (Clean Env)";
      genericName = "Email Client";
      exec = "env LD_LIBRARY_PATH= ${pkgs.thunderbird}/bin/thunderbird %u";
      terminal = false;
      categories = [ "Application" "Network" "Email" ];
      mimeType = [ "x-scheme-handler/mailto" ];
      icon = "thunderbird"; # Ensures the icon still shows up
    };

    # 2. Force the association
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/mailto" = "thunderbird-clean.desktop";
      };
    };

  # 1. Install the Wallpaper file
  home.file.".local/share/backgrounds/wallpaper-molly.jpg".source =
    ../../assets/wallpapers/wallpaper-molly.jpg;

  # 2. Configure GNOME Settings
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # Enable the app indicator extension (tray icons)
        enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" ];
        # favorite-apps = [
        #   "org.gnome.Nautilus.desktop"
        #   "firefox.desktop"
        #   "com.mitchellh.ghostty.desktop"
        # ];
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        clock-format = "12h";
        color-scheme = "prefer-dark";
      };

      # Set desktop background for dark and light mode
      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.home.homeDirectory}/.local/share/backgrounds/wallpaper-molly.jpg";
        picture-uri-dark = "file://${config.home.homeDirectory}/.local/share/backgrounds/wallpaper-molly.jpg";
      };
    };
  };
}
