 # flake.nix                                                                                                                    
 # main flake, defines inputs [dependencies] & outputs [resulting system configs]
{
  description = "a nucleation site upon which water vapor will crystallize";

  
  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  # an attribute set that defines all dependencies of this flake. passed as args to outputs after being fetched.
  # deps can be another flake, a git repo, local path, etc.
  # for github:owner/name/reference, reference can be branch, commit-id, or tag.
  # other packages can be referenced in files which include `outputs` directly with `inputs`.`packagename`.packages."${pkgs.stdenv.hostPlatform.system}".`name-of-package`
  # If doing so with a software, it will be compiled from the provided source.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    agenix.url = "github:ryantm/agenix";
    
    # otherpkgs-input.url = "github:username/repo-name/branch-name"; e.g. stable 
    # helix.url = "github:helix-editor/helix/master" # helix editor, can use software repos here. (useful for software not yet added/updated in nixpkgs)
    

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";

      # `follows` kwd used for inheritance. `inputs.nixpkgs` of home-manager is kept consistent with `inputs.nixpkgs` of current flake to avoid problems caused by diff versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Outputs
  # A function that takes the deps from inputs as params and returns an attr set, represents the build results of this flake
  # nixos-rebuild switch looks for the nixosConfigurations."hostname" attribute in the attr set returned by outputs fn in a given flake
  # can use `nixos-rebuild switch --flake /path/to/flake#your-hostname to specify a difference flake and different hostname.'
  # the --flake command can also reference a remote github repo, e.g. `--flake github:owner//repo#your-hostname`.
  #
  # The special input `self` refers to the outputs and source tree of this flake. 
  # `self` is the return value of this outputs fn and the path to the current flake's source tree.
  outputs = inputs@{ 
    self, 
    nixpkgs,
    nixpkgs-stable, 
    home-manager,
    agenix, 
    ... 
  }: 
  {
    # NixOS Configuration entrypoint
    # Available through: `nixos-rebuild --flake .#hostname`
    nixosConfigurations = {

      # === Hosts ===
      
      # Main desktop
      penrose = 
      let
        username = "bee";
        system = "x86_64-linux";

        # Import overlays, passing inputs so it can access nixpkgs-stable, etc.
        overlays = import ./overlays { inherit inputs; };

        specialArgs = { inherit username inputs; };
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs system;

          
          modules = [
            ./machines/penrose/configuration.nix
            agenix.nixosModules.default # provides age.* options

            # Apply overlays to system's nixpkgs
            {
              nixpkgs.overlays = [
                overlays.stable-packages
                # overlays.additions
                # overlays.modifications
              ];
            }

            # Add Home Manager NixOS module
            home-manager.nixosModules.home-manager

            # Configure Home Manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;    
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${username} = import ./users/bee/hosts/penrose.nix;
            }
          ];
        
        };
      };  
  };

  
}
