#!/usr/bin/env bash
# specifically for diff-so-fancy
PAGER=''
if ! command -v diff-so-fancy &> /dev/null
then
    PAGER='less --tabs=4 -RFX'
    git config --bool --global so-fancy.markEmptyLines false
else
    PAGER='diff-so-fancy | less --tabs=4 -RFX'
    git config --bool --global diff-so-fancy.markEmptyLines false
fi

git config --global core.pager "$(PAGER)"

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
#TODO: do an os check
git config --global credential.helper osxkeychain
git config --global alias.pushu "push -u origin HEAD"  # set the upstream branch to your working branch
