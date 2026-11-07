Just my current dotfiles... exciting, eh?

## New machine

```bash
curl https://mise.run | sh
~/.local/bin/mise bootstrap --from https://github.com/darrenboyd/dotfiles.git --from-dir ~/code/dotfiles --force-dotfiles
```

That clones this repo to `~/code/dotfiles`, adds the apt repositories and installs the
packages in `mise.toml`, links the dotfiles, installs the global tools, and runs the
`bootstrap` task. `--force-dotfiles` replaces the distro's stock `~/.bashrc` (a fresh
user always has one). On a machine you've already customized, run it without that flag
and deal with each conflict it lists. Open a new terminal afterwards.

## Day to day

    dot status          # what's applied
    dot add --local --source config/<app> ~/.config/<app>   # adopt a config
    dotrun doctor       # drift: undecided configs, stray scripts, secrets
    dotrun dot:check    # shell regression check

`dot` and `dotrun` are aliases for `mise -C ~/code/dotfiles dot|run`. The design and how
the repo got this shape: [docs/designs/dotfiles-modernization.md](docs/designs/dotfiles-modernization.md).
How mise actually behaves here: [docs/mise-notes.md](docs/mise-notes.md).

## OSX Notes

Make it possible to 'quit' finder.


    $ defaults write com.apple.finder QuitMenuItem YES

Even when Finder is running, don't display files on 'Desktop'.

    $ defaults write com.apple.finder CreateDesktop -bool false

After both or either of those...

    $ killall Finder

Install Slate:

* https://github.com/mattr-/slate
