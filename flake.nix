{
  description = "NixOS Config for Framework Laptop";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration (Crucial for Framework)
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # dotfiles = {
    #   url = "git+https://github.com/espdesign/dotfiles.config.git";
    #   flake = false;
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      #nixpkgs-stable,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # 1. Define the systems you support (usually just x86_64-linux)
      systems = [ "x86_64-linux" ];

      # 2. Define the helper function that iterates over those systems
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # --- HELPER FUNCTION ---
      # This reduces boilerplate. It creates a system definition
      # merging the hostname, common modules, and hardware specs.
      mkSystem =
        {
          hostname,
          system ? "x86_64-linux",
          modules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            # Import the host-specific configuration
            ./hosts/${hostname}

            #Standard Home Manager Integration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              # Import the user configuration
              home-manager.users.evan = import ./home/evan.nix;
            }
          ]
          ++ modules; # Append extra modules passed to the function
        };
    in
    {
      # Custom Packages (Optional, formatted for all systems)
      # Now 'forAllSystems' is defined, so this will work!
      # packages = forAllSystems (
      #   system:
      #   import ./pkgs {
      #     pkgs = nixpkgs.legacyPackages.${system};
      #   }
      # );

      # --- HOST CONFIGURATIONS ---
      nixosConfigurations = {
        # Desktop
        # kitava-desktop = mkSystem {
        #   hostname = "kitava-desktop";
        # };

        # Framework Laptop (12th Gen)
        sin-laptop = mkSystem {
          hostname = "framework";
          modules = [
            # Framework specific hardware optimizations
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
      };
    };
}
