#!/usr/bin/env bash
# specifically for diff-so-fancy

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
git config --global diff-so-fancy.rulerWidth 47    # git log's commit header width
git config --bool --global diff-so-fancy.markEmptyLines false
git config --global credential.helper osxkeychain
git config --global alias.pushu "push -u origin HEAD"  # set the upstream branch to your working branch
