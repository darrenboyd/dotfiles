{
  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv {
      name = "darrens";
      paths = [
        git
        direnv
        file
        graphviz
        nix
        nodejs
        silver-searcher
      ];
    };
  };
}
