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


# Resources
This cart makes use of several libraries.


## draw svg 1.1 by txori

--svg converted with https://www.txori.com/index.php?static14/pico8


Creating SVG Data with Inkscape:
-- 1. press b on keyboard 
-- 2. choose spiro tool
-- 3. create a shape
-- 4. open in text editor
-- 5. select path string value
-- 6. in other words,
-- 7. what's between the quotes
-- 8. use the txori tool above
-- 9. replace the svg table below
-- 10. run cart
-- 11. first number is color


thanks http://www.f-legrand.fr/scidoc/docmml/graphie/geometrie/bezier/bezier.html

