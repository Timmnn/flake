{
  description = "timm-nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #TODO: is this still needed?
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        # Allows software with unfree licenses
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        timm-nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit system; };
          modules = [
            # System config
            ./nixos/configuration.nix
            # HomeManager setup
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.timm = import ./home/personal.nix;
            }
            ({ pkgs, ... }: {
              #TODO: is this still needed?
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = with pkgs;
                [ rust-bin.stable.latest.default ];
            })
          ];
        };
      };
    };
}
