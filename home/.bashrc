# Include path variable
if [ -f ~/.env ]
  then
   source ~/.env
fi

# Include colors file
if [ -f ~/.colors ]
  then
   source ~/.colors
fi

# Include git completion
if [ -f ~/.git-completion.sh ]
  then
   source ~/.git-completion.sh
fi

# Include alias file
if [ -f ~/.aliases ]
  then
   source ~/.aliases
fi

# Include functions file
if [ -f ~/.bash_functions ]
  then
   source ~/.bash_functions
fi

# Shhh...
if [ -f ~/.secrets ]
  then
   source ~/.secrets
fi

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Override shunit2 output format
if [ -f ~/.shunit2 ]
  then
   source ~/.shunit2
fi

export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
fi
# Prompt

prompt="\[$green\]\w:\[$end\] "

PS1="$prompt"
git_branch="\[$yellow\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '\1')\"\`\[$end\] "
export PS1="${git_branch}${prompt}"
export PS2="\[$yello\] > \[$end\]"

# Make bash check it's window size after a process completes
shopt -s checkwinsize