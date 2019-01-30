## My ZSH config

* It uses [pure-promt](https://github.com/sindresorhus/pure).
* It uses [asdf](https://asdf-vm.github.io/asdf/#/) as runtime manager.
* Place your environmental variables in the `environment` file.
* Place your custom stuff in the `user` file.
* Place your ssh stuff in the `ssh` file.

### Aliases and functions

#### Fzf

- `fzfp` -> Will open `fzf` with preview
- `fo` -> fzf + open the selected file
- `da` -> Select a docker container to start and attach to
- `fbr` -> Checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches

#### Git

- `ga` -> `git add`
- `gc` -> `git commit -m`
- `gco` -> `git checkout`
- `gst` -> `git status`
- `gl` -> Git log with one commit per line
- `gld` -> Similar to `gl` but including commit description
- `gpush` -> `git push`
- `gpull` -> `git pull`
- `gbcopy` -> "git branch | grep '^\*' | cut -d' ' -f2 | pbcopy"
- `gsign-all` -> This will execute a rebase with the branch you pass, and sign all the commits
- `gd` -> `git diff`
- `git-clean-branches` -> Will delete all local branches except the current one and master


#### Docker

- `docker-clean` -> Removes all docker images
- `docker-containers-clean` -> Stops and removes all docker containers
- `docker-clean-all` -> `docker-clean && docker-containers-clean`


#### Misc

- `hackit` -> Will open the current directory in MacVim
- `rubyserver` -> Will start a web server on port 5000 serving your current directory
