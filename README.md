# simple-dissertation
A simple Latex class for writing a dissertation without much hassle

*Disclaimer: This work is currently under development. I am happy about any contributions or remarks. If there are problems, please contact me.*

## Setup

Just clone the directory from here with 

```
git clone git@github.com:timkittel/simple-dissertation.git
```

and copy the `simple-dissertation.cls` in your project folder. 

### Autocompletion

Enabling auto-completion depends on the editor you're using. The `class-simple-dissertation.cwl` provides all the info for that. In case of **Texstudio** on Linux link it into `$HOME/.config/texstudio/completion/user/`. The easiest way to do that is to run the following command in terminal when being in the directory you cloned the repo to:

```
ln -s "$(pwd)/class-simple-dissertation.cwl" "$HOME/.config/texstudio/completion/user/class-simple-dissertation.cwl
```

Note that this only creates a link, so please keep the directory you clone from git. Also, for any updates you can simply `git pull` the updates and copy the new `simple-dissertation.cls` to your project folder. Autocompletion will be updated automatically via the link.

### Biber

`simple-dissertation` uses `biber` as the backend to read your `.bib`-file. Make sure it is installed (`sudo apt-get install biber` on Ubuntu) and your editor is actually using it (in Texstudio: Options --> Configure --> Build --> Default Bibliography Tool --> Biber).

## Example

Try out the example. It shows a basic version (: