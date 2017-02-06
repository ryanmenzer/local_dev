[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source ~/.bashrc
source ~/.profile
alias yolo='rails db:drop db:create db:migrate db:fixtures:load'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

export EDITOR=atom
export GIT_EDITOR=atom

# https://github.com/jcgoble3/gitstuff/blob/master/gitprompt.sh
# Adds the current branch to the bash prompt when the working directory is
# part of a Git repository. Includes color-coding and indicators to quickly
# indicate the status of working directory.
#
# To use: Copy into ~/.bashrc and tweak if desired.
#
# Based upon the following gists:
# <https://gist.github.com/henrik/31631>
# <https://gist.github.com/srguiwiz/de87bf6355717f0eede5>
# Modified by me, using ideas from comments on those gists.
#
# License: MIT, unless the authors of those two gists object :)

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[0;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[0;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[0;31m'  # bold red
    else
        echo -e '\033[0;36m'  # bold cyan
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02"  # last bit resets color
    fi
}

export PS1='\[\033[0m\]\W$(git_prompt)$ '

# git autocomplete
# install:
# 1. curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
# 2. chmod -X ~/.git-completion.bash

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

#mongodb binary
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

#loads Node nvm
[ -s "/Users/ryan/.nvm/nvm.sh" ] && . "/Users/ryan/.nvm/nvm.sh"

# searches history of ls commands
bind '"^[[A":history-search-backward'
bind '"^[[B":history-search-forward'
