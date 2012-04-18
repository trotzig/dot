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
motivation to do so as they are far less common.

## Installation
Clone the repository:

    git clone git://github.com/sds/dot.git

Run the install script:

    cd ~/dot
    ./install.sh

You're all set. Don't worry, Dot will backup any dot files it replaces.

## Etymology
'Dot' comes from the fact that it ultimately manages 'dot' files, and is a
tribute to [Dot Matrix][DotMatrix] of [ReBoot][ReBoot] fame.

## License
[WTFPL][WTFPL]

[DotMatrix]: http://reboot.wikia.com/wiki/Dot_Matrix
[ReBoot]: http://en.wikipedia.org/wiki/ReBoot
[WTFPL]: http://en.wikipedia.org/wiki/WTFPL
