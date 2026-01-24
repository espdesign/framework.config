{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/user-apps.nix
    ../modules/home-manager/user-gnome.nix
    ../modules/home-manager/terminal.nix
    ../modules/home-manager/syncthing.nix
    # ../modules/home-manager/zsh.nix
  ];
  home.username = "evan";
  home.homeDirectory = "/home/evan";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Evan Pendergraft";
        email = "evanpendergraft@gmail.com";
      };

      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  home.packages = with pkgs; [
    # Core Utils
    coreutils
    fd
    htop
    httpie
    jq
    ripgrep
    tldr
    zip
    unzip
    xz
    wl-clipboard
    file
    which
    glow
    procs
    yq-go

    # Network / Security
    nmap
    wget

    # Dev / Build Tools
    gcc
    gnumake
    cargo
    cachix
    devenv

    #dev servers
    package-version-server
    dockerfile-language-server

    nixd
    alejandra

    # Python Environment
    (python3.withPackages (
      ps: with ps; [
        pyright
        black
        pynvim
        debugpy
      ]
    ))

    # Media
    yt-dlp
  ];
  home.stateVersion = "24.05";
}
