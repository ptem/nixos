## THIS AINT DONE YET COWPOKE

## { config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ardour
    supercollider

    # probably move haskell stuff out of here tbqh, need to install tidal and whatnot in some way
    # see the tidalcycles resources
    stable.ghc
    stable.haskellPackages.haskell-language-server
    stable.haskellPackages.cabal-install

  ];

}
