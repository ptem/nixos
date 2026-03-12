# flake.nix
{
  description = "an accumulation point originating from a particle to which water vapor adheres and freezes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    agenix.url = "github:ryantm/agenix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      username = "bee";
      system = "x86_64-linux";
      # import overlays with inputs to access stable nixpkgs
      overlays = import ./overlays { inherit inputs; };
      specialArgs = { inherit username inputs; };
    in
    {
      nixosConfigurations.penrose = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/penrose/default.nix
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager

          # apply overlays globally
          { nixpkgs.overlays = [ overlays.stable-packages ]; }
        ];
      };
    };
}
