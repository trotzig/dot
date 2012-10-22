# Dot
Dot is a framework for managing configuration of multiple shells, and dot
files in general.

It was motivated by three goals:

* Providing a way to gracefully degrade from `zsh` to `bash` in the event
  `zsh` wasn't available
* Allowing easy switching between shells when pair programming (for example
  if one pair prefers `bash`)
* Wanting to learn more about the idiosyncrasies of `bash` and `zsh`

While it currently only supports `bash` and `zsh`, in theory there's nothing
preventing it from supporting `csh` or others---there's just little
motivation to do so as they are far less commonly used.

## Installation
Clone the repository:

    git clone git://github.com/sds/dot.git

Run the install script:

    cd ~/dot
    ./install

You're all set. Don't worry, Dot will backup any dot files it replaces.

## Organization
Dot allows you to organize configuration settings into logical groups. The
`plugins` directory contains a folder for each one of these groups (e.g. an
`ssh` folder for SSH-related settings, or a `git` folder for git-related
settings).

Each of these directories can contains files of the form
`plugin.{sh,bash,zsh}`. `plugin` files are loaded on shell startup, and perform
any environment initialization (e.g. exporting variables) to support the
particular plugin.

For any file that is loaded from a plugin, the `.sh` extension is loaded
first. `.sh` files are intended to represent code that runs regardless of
which shell you are using (i.e. it should contain shell-agnostic code).

Next, any file with the shell-specific extension of the current shell (e.g.
`.bash` or `.zsh`) is loaded to run commands specific to that shell. This
allows you to tweak your configuration on a per-shell basis.

In each plugin, there may also be an installation script `setup.sh`, and
other configuration files related to the plugin. For example, a plugin
directory for git would likely have `gitconfig` and `gitignore` files, along
with an `setup.sh` script which symlinks these files to the user's home
directory.

Look at the `plugins` directory for examples of how this organizational system
works in practice. The environment variables `DOTDIR`, `DOTPLUGIN`,
`DOTLOGDIR`, and `DOTTMPDIR` are useful when writing your own plugins.

## Writing a Plugin
Writing your own plugin with Dot is designed to be easy. To start, you need
to identify what you want your plugin to do.

  * Does it install files in your home directory?
  * Does it set any environment variables?
  * Does it declare any aliases or functions for use in your shell?

If you're installing any sort of files or repository, you'll need to add a
`setup.sh` script to your plugin, and in that either have a `setup` function
which makes the appropriate calls to `symlink`, `file`, `repo`, etc., or
individual `install`/`uninstall` functions to carry out the install/uninstall
commands by hand.

If you're setting environment variables, aliases, or defining custom functions,
these should go in the `plugin.sh` file.

## Etymology
'Dot' comes from the fact that it ultimately manages 'dot' files, and is a
tribute to [Dot Matrix][DotMatrix] of [ReBoot][ReBoot] fame.

## License
[WTFPL][WTFPL]

[DotMatrix]: http://reboot.wikia.com/wiki/Dot_Matrix
[ReBoot]: http://en.wikipedia.org/wiki/ReBoot
[WTFPL]: http://en.wikipedia.org/wiki/WTFPL
