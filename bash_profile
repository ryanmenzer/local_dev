[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source ~/.bashrc
source ~/.profile
alias yolo='rails db:drop db:create db:migrate db:fixtures:load'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

export EDITOR=atom
export GIT_EDITOR=atom

alias cm='commit -m'
alias st='status'

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1='\[\033[0m\]\W$(parse_git_branch)$ '

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
