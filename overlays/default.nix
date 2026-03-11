{
  inputs,
  ...
}:

{
  # Adds any custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs final.pkgs;

  # Modifications to be overlain -- change versions, patches, set compilation flags, anything.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec { ... });
  };


  # When applied, the stable nixpkgs [defined in flake.nix] set will be accessible through pkgs.stable
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

}
