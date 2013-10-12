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
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
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
prompt_color="${lightblue}"
git_dirty_color="${redb}"
git_clean_color="${greenb}"

prompt="\[$prompt_color\]\w ❯ \[$end\]"
PS1="${prompt}"
PS2="\[$yellow\]❯❯ \[$end\]"
export PROMPT_COMMAND="git_prompt"
# Make bash check it's window size after a process completes
shopt -s checkwinsize
