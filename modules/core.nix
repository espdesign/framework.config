# CORE SYSTEM SHARED ACROSS USERS
# ADD SYSTEM PACKAGES FOR ALL USERS IN THIS FILE
{
  pkgs,
  # inputs,
  ...
}:
{
  # Nix Settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ]; # enable flakes
    trusted-users = [
      "root"
      "evan"
    ]; # allow root and evanp to use nix
  };
  # nix garbage collection, https://nixos.wiki/wiki/Storage_optimization#Automation
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Allow unfree packages (Chrome, VSCode, etc)
  nixpkgs.config.allowUnfree = true;
  # Locale & Time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User Configuration, Needed for Home Manager to attach
  users.users.evan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "$6$gMclef8wWibtLst0$6f0JIElUbX3DvW78zAOhLOesfigbHrMN0hzRgTDZaFjbG8uP6Nkzjm4an1AM0VriCyrLG8ECrHIJn.6OHbgdP0";
  };
  #enable zsh system-wide
  programs.zsh.enable = true;

  # Universal packages, or tools you always want accessible
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    # easyeffects # PIPEWIRE GUI TOOL
    # Browsers
    firefox
    google-chrome
  ];

  fonts.packages = with pkgs; [
    fira-code
    font-manager
    font-awesome_5
    noto-fonts
    jetbrains-mono
  ];
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Optional: If you want to use JACK applications
    # jack.enable = true;
  };

  # 1. Enable CUPS to print documents.
  services.printing.enable = true;

  # 2. Enable Autodiscovery of Network Printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # Open UDP 5353 for Avahi
  };
  # Enable Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "evan" ];

}
