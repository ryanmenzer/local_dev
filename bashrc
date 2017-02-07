PATH=/usr/local/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PS1='\W \$ '

# nvm
export NVM_DIR="/Users/ryanmenzer/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
