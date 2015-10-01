Just my current dotfiles... exciting, eh?


Symlink all the dotfiles into the appropriate locations:

  rake install

## OSX Notes

Make it possible to 'quit' finder.


    $ defaults write com.apple.finder QuitMenuItem YES

Even when Finder is running, don't display files on 'Desktop'.

    $ defaults write com.apple.finder CreateDesktop -bool false

After both or either of those...

    $ killall Finder

Install Slate:

* https://github.com/mattr-/slate
