Dotfiles
========

Dotfiles uses [Dotbot][dotbot] for installation.

How to use
----------

    $ git clone http://github.com/tbrixen/dotfiles
    $ cd dotfiles
    $ ./install

The vim plugin YouCompleteMe is included. For this to work it must be compiled. This requires `python` and `cmake`. Install the plugin using

    $ vim/bundle/YouCompleteMe/install.py

Windows users see https://bitbucket.org/Alexander-Shukaev/vim-youcompleteme-for-windows.

Making local customizations
---------------------------

* `.gitignore` : `~/.gitignore_local`
* `.bashrc` : `~/.bashrc_local_before` runs first
* `.bashrc` : `~/.bashrc_local_after` runs after


[dotbot]: https://github.com/anishathalye/dotbot