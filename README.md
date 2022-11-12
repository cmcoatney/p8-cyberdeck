# Installation

1. Install Pico-8 from <a href="https://www.lexaloffle.com/pico-8.php">Lexaloffle</a>
2. from Pico-8 command prompt, type: `folder` to open the carts directory
3. place the cyberdeck.p8 file in that directory
4. from Pico-8 command prompt, type: `load cyberdeck`
5. from Pico-8 command prompt, type: `run` to launch game

# Quick Start: MAC

1. Launch Cyberdeck in Pico-8 from Terminal

```zsh
/Applications/PICO-8.app/Contents/MacOS/pico8 -run ~/Library/Application\ Support/pico-8/carts/cyberdeck.p8
```

2. Open the project in VSCODE (replace username with your path )

```zsh
code "/Users/<username>/Library/Application Support/pico-8/carts/cyberdeck"
```

# Notes

This repository includes the cyberdeck.p8 file which imports lua files.
Outside of this repository should be a symbolic link to the cyberdeck.p8 found here.
This will allow the folder to contain development assets without cluttering the
pico-8 carts folder (this folder and a symlink is better than 20 files per project)
