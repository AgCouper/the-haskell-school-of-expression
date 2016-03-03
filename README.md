The source code typed from the book "The haskell School of Expression".

- The code uses "soegtk" for graphics.
- The soegtk in Cabal was outdated, so I had to download the sources from https://github.com/gtk2hs/soegtk, 
  update the dependencies in Cabal config, so it would build with the latest version of the packages it depends upon,
  and build it from source.
- On Mac, gtk should be installed with "cabal install gtk -fhave-quartz-gtk" command.
- Before installing Haskell gtk bindings, one should install Gtk for OS X. Brew has it.
- Cabal doesn't install gtk2hs automatically, even though gtk bindings depend on it.
  So, it should be installed manually, via "cabal install gtk2hs".


