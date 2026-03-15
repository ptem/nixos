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

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      superusers = [
        "bee"
      ];
      users = [ ];
      systems = [ "x86_64-linux" ];

      domain = "axolotlsin.space";
      navidromeServer = "navi.axolotlsin.space";

      # import overlays with inputs to access stable nixpkgs
      overlays = import ./overlays { inherit inputs; };
      specialArgs = {
        inherit
          inputs
          users
          superusers
          domain
          navidromeServer
          ;
      };

      #  Generates an attribute for each function passed, with supported systems as an arg.
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # custom packages (thru nix build, nix shell, etc)
      # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # formatter for nix files, through nix fmt (alejandra, nixpkgs-fmt)
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # reusable nixos modules potentially want to export. stuff you would upstream into nixpkgs.
      # nixosModules = import ./modules/nixos;

      # reusable HM modules potentially want to export / would want to upstream into HM
      # homeManagerModules = import ./modules/home-manager;

      # NixOS system configuration entrypoint
      # Available through nixos-rebuild --flake .#hostname
      nixosConfigurations = {

        # Machine: Penrose
        penrose = nixpkgs.lib.nixosSystem {
          # Passes inputs and username to all system modules
          specialArgs = { inherit inputs users superusers; };

          modules = [

            # Main nixos configuration file
            ./hosts/penrose/default.nix

            # Agenix slop
            inputs.agenix.nixosModules.default

            {
              nixpkgs.overlays = [
                # overlays.additions
                overlays.modifications
                overlays.stable-packages
              ];
            }
          ];
        };

      };

      # Standalone Home-Manager configuration entrypoint
      # Available through home-manager --flake .#username@hostname
      homeConfigurations = {

        "bee@penrose" = home-manager.lib.homeManagerConfiguration {

          # requires pkgs instance
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs navidromeServer; };

          modules = [
            ./users/bee/default.nix

            {
              nixpkgs.overlays = [
                # overlays.additions
                overlays.modifications
                overlays.stable-packages
              ];
            }
          ];

        };
      };

    };
}
