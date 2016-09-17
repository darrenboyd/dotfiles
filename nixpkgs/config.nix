{
  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        git
        direnv
        elixir
        erlang
        file
        graphviz
        nix
        nodejs
        silver-searcher
        watchman
      ];
    };
  };
}
