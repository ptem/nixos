# flake.nix
{
  description = "an accumulation point originating from a particle to which water vapor adheres and freezes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    agenix.url = "github:ryantm/agenix";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      stylix,
      ...
    }:
    let
      superusers = [
        "bee"
      ];
      users = [ ];
      systems = [ "x86_64-linux" ];

      # import overlays with inputs to access stable nixpkgs
      overlays = import ./overlays { inherit inputs; };
      specialArgs = {
        inherit
          inputs
          users
          superusers
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
          specialArgs = {
            inherit inputs users superusers;
            isHM = false;
          };

          modules = [

            inputs.agenix.nixosModules.default
            stylix.nixosModules.stylix

            ./hosts/penrose/default.nix
            ./style/stylix/default.nix

            {
              nixpkgs.overlays = [
                # overlays.additions
                overlays.modifications
                overlays.stable-packages
              ];
            }

            { nixpkgs.config.allowUnfree = true; }
          ];
        };

        # Machine: Sierpinski
        sierpinski = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs users superusers;
            isHM = false;
          };

          modules = [
            inputs.agenix.nixosModules.default

            ./hosts/sierpinski/default.nix

            {
              nixpkgs.overlays = [
                overlays.modifications
                overlays.stable-packages
              ];
            }
            { nixpkgs.config.allowUnfree = true; }
          ];
        };

      };

      # Standalone Home-Manager configuration entrypoint
      # Available through home-manager --flake .#username@hostname
      homeConfigurations = {

        "bee@penrose" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            overlays = [
              overlays.modifications
              overlays.stable-packages
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
            username = "bee";
            isHM = true;
          };

          modules = [
            ./users/bee/default.nix
            ./hm/desktop.nix

            stylix.homeModules.stylix
            ./style/stylix/default.nix
          ];
        };

        "bee@sierpinski" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            overlays = [
              overlays.modifications
              overlays.stable-packages
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
            username = "bee";
            isHM = true;
          };

          modules = [ ./users/bee/default.nix ];
        };
      };

    };
}
