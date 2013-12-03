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
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Include alias file
if [ -f ~/.aliases ]
  then
   source ~/.aliases
fi

if [ -f /usr/local/opt/node/lib/node_modules/npm/lib/utils/completion.sh ]; then
  source /usr/local/opt/node/lib/node_modules/npm/lib/utils/completion.sh
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
git_dirty_color="${yellow}"
git_clean_color="${green}"

prompt="\[$prompt_color\]\w ❯ \[$end\]"
PS1="${prompt}"
PS2="\[$yellow\]❯❯ \[$end\]"
export PROMPT_COMMAND="render_prompt"
# Make bash check it's window size after a process completes
shopt -s checkwinsize
