{ pkgs, ... }:
{
  imports = [
    ./hardware.nix # hardware specific to this machine
    ../../modules/core.nix # core system shared across hosts
    ../../modules/gnome.nix # gnome system
    # ../../modules/gnome-desktop.nix # gnome desktop
    # ../../modules/pipewire-sound.nix # pipewire sound
    # ../../modules/printing.nix # printing
    # ../../modules/docker.nix
  ];
  networking.hostName = "framework-evan";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.05";
}
