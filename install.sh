#!/bin/bash

if [ "$PWD" != "$HOME/.dotfiles" ]; then
  DOTFILES_PATH="$PWD"
else
  DOTFILES_PATH=".dotfiles"
fi

function install_symlink {
  if [ ! -h "$HOME/$1" ]; then
    echo "Symlinking $1"
    if [[ "$(basename $1)" != "$HOME" ]] && [[ "$DOTFILES_PATH" != /* ]]; then
      ln -s "$HOME/$DOTFILES_PATH/$2" "$HOME/$1"
    else
      ln -s "$DOTFILES_PATH/$2" "$HOME/$1"
    fi
  else
    echo "Skipping $1, already exists"
  fi
}

# shell
install_symlink ".aliases" "sh/aliases.symlink"
install_symlink ".profile" "sh/profile.symlink"

# bash
install_symlink ".bash_aliases" "bash/aliases.symlink"
install_symlink ".bashrc" "bash/bashrc.symlink"
install_symlink ".profile" "bash/profile.symlink"

# tmux
if hash tmux 2>/dev/null; then
  install_symlink ".tmux.conf" "tmux/tmux.conf.symlink"
fi

# vim
if hash vim 2>/dev/null; then
  install_symlink ".vimrc" "vim/vimrc.symlink"
  install_symlink ".vim" "vim/"
  git submodule init
  git submodule update --recursive
fi

# git
if hash git 2>/dev/null; then
  install_symlink ".gitaliases" "git/gitaliases.symlink"
  install_symlink ".gitconfig" "git/gitconfig.symlink"
  install_symlink ".gitignore" "git/gitignore.symlink"
fi

# ruby
if hash ruby 2>/dev/null; then
  install_symlink ".gemrc" "ruby/gemrc.symlink"
  install_symlink ".irbrc" "ruby/irbrc.symlink"
  install_symlink ".rspec" "ruby/rspec.symlink"
  install_symlink ".rubocop.yml" "ruby/rubocop.yml.symlink"
  install_symlink ".pryrc" "ruby/pryrc.rb"
fi

# osx
if [ "$(uname)" == "Darwin" ]; then
  # screenshots folder
  mkdir -p $HOME/Pictures/Screenshots
  defaults write com.apple.screencapture location $HOME/Pictures/Screenshots

  # install keybindings
  mkdir -p $HOME/Library/KeyBindings
  install_symlink "Library/Keybindings/DefaultKeyBinding.dict" "osx/DefaultKeyBinding.dict"
fi
