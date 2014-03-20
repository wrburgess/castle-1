function d {
  cd ~/Development

  if [ -n "$1" ]; then
    cd $1
  fi
}

function project {
  cd ~/Development/$CURRENT_PROJECT
}

function stfu {
  open -a Flowdock
  open -a localhost:3000 -a "Google Chrome"
  open -a Airmail
  project
  if [[ -n "$1" ]]; then
    $($1 .)
  else
    s .
  fi
}

function sp {
  SPEC_ROOT="spec"
  FILE="$2"
  LINE=""
  if [[ -n "$3" ]]; then
    for LINE; do true; done
    LINE=":${LINE}"
  fi
  if [[ -n "$FILE" ]]; then
    SUFFIX="_spec.rb"
  else
    SUFFIX=""
  fi

  case "$1" in
  "c" )
    if [[ -n "$FILE" ]]; then
      FILE="${FILE}_controller"
    fi
    bundle exec rspec "${SPEC_ROOT}/controllers/${FILE}${SUFFIX}${LINE}" ;;
  "m" )
    bundle exec rspec "${SPEC_ROOT}/models/${FILE}${SUFFIX}${LINE}";;
  "mm" )
    if [[ -n "$FILE" ]]; then
      FILE="${FILE}_mailer"
    fi
    bundle exec rspec "${SPEC_ROOT}/mailers/${FILE}${SUFFIX}${LINE}";;
  "w" )
    if [[ -n "$FILE" ]]; then
      FILE="${FILE}_worker"
    fi
    bundle exec rspec "${SPEC_ROOT}/workers/${FILE}${SUFFIX}${LINE}" ;;
  "" )
    bundle exec rspec "${SPEC_ROOT}";;
  * )
    bundle exec rspec "${SPEC_ROOT}/${1}/${2}${SUFFIX}${LINE}";;
  esac
}

function bundle {
  bundler_cmd=`which bundle`
  if [ -z "$1" ] || [ "$1" == "install" ]; then
    if [ ! -d .bundle/bin ]; then
      $bundler_cmd --binstubs .bundle/bin
    else
      $bundler_cmd
    fi
  else
    $bundler_cmd "$@"
  fi
}

function gd {
  if [ -n "$1" ] && [ ! -z "$2" ]; then
      git difftool -y "$1" "$2"
  else
      git difftool -y
  fi
}

function mou {
  if [ -n "$1" ]; then
    open "$1" -a Mou
  else
    open -a Mou
  fi
}

function offline {
  if [ -n "$1" ] && [ ! -z "$2" ]; then
    if [ ! -d "~/Development/offline/$1" ]; then
      mkdir -p ~/Development/offline/"$1"
    fi

    cd ~/Development/offline/"$1"
    wget -rkp -l10 -np -nH "$2"
  else
    echo "Usage: offline example http://example.com"
  fi
}

function pull {
  if [ -n "$1" ]; then
    git pull origin "$1"
  else
    branch=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $branch
  fi
}

function push {
  if [ -n "$1" ]; then
    git push origin "$1"
  else
    branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin $branch
  fi
}

function s {
  if [ -n "$1" ]; then
    touch "$1" && open "$1" -a "Sublime Text"
  else
    open "./" -a "Sublime Text"
  fi
}

function a {
  if [ -n "$1" ]; then
    touch "$1" && atom "$1"
  else
    atom .
  fi
}

function e {
  if [ -n "$1" ]; then
    open "$1" -a Emacs
  else
    open . -a Emacs
  fi
}

function badtouch {
  if [ ! -f "$1" ]; then
    touch $1
  fi
}

function tickle {
  if [ -n "$1" ] && [ ! -f "$1" ]; then
    path=$(dirname $1)

    [ ! -d "$path" ] && mkdir -p $path
    /usr/bin/touch "$1"
  else
    echo "tickle will mkdir -p and touch the file at the end of the path"
    echo
    echo "Usage:"
    echo "  tickle path/to/filename.ext"
  fi
}

function touch {
  if [ "$1" == "-p" ]; then # fuck with the touch command
    if [ -n "$2" ]; then
      tickle "$2"
    else
      echo "Usage:"
      echo "  touch -p /non/existent/path/to/filename.ext"
    fi
  else # pass through to the real touch command
    /usr/bin/touch "$@"
  fi
}

function pr {
  local dir="$PWD"

  until [[ -z "$dir" ]]; do
    if [ -d ./.git ]; then
      break
    else
      cd ..
    fi
    dir="${dir%/*}"
  done
}

function show {
  if [ -n "$1" ]; then
    ls -alh | grep "$1"
  else
    echo "show is a small utility that runs ls -alh,"
    echo "then pipes the output to grep filtered by"
    echo "the (filename) argument."
    echo
    echo "  Usage: show (filename)"
  fi
}

function nx {
  if [ -n "$1" ]; then
    if [ "$1" == "start" ]; then
      `launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist` && echo "nginx started"
    fi

    if [ "$1" == "restart" ]; then
      `launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist` &&  `launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist` && echo "nginx restarted"
    fi

    if [ "$1" == "stop" ]; then
      `launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist` && echo "nginx stopped"
    fi

  fi
}

function pman {
  if [ -n "$1" ]; then
    man -t "${1}" | open -f -a /Applications/Preview.app
  else
    echo "Usage: pman [application]"
  fi
}

function copy {
  if [ -n "$1" ]; then
    if [ -f "$1" ] && [ ! -d "$1" ]; then
      cat "$1" | pbcopy
      echo "copied!"
    else
      if [ -d "$1" ]; then
        echo "$1 is a directory"
      else
        echo "No such file $1"
      fi
      echo
      echo "Usage:"
      echo "  copy <filename>"
    fi
  fi
}

function add {
  if [ -z "$1" ]; then
    git add -p
  else
    git add "$@" -u
  fi
}

function example {
  echo "\$# = $# (argument count)"
  echo "\$@ = $@ (arguments)"
  echo
  echo '$*';
  for p in $*;
  do
      echo "  [$p]";
  done;
  echo '"$*"';
  for p in "$*";
  do
      echo "  [$p]";
  done;
  echo '$@';
  for p in $@;
  do
      echo "  [$p]";
  done;
  echo '"$@"';
  for p in "$@";
  do
      echo "  [$p]";
  done

  echo
  echo ----- String tests

  if [ -z "$1" ]; then
    echo 'First argument is an empty string'
  fi

  if [ -n "$1" ]; then
    echo 'First argument is a non-empty string'
  fi

  if [ "a" == "a" ]; then
    echo '"a" == "a"'
  fi

  if [ "a" != "b" ]; then
    echo '"a" != "b"'
  fi

  if [ "b" > "a" ]; then
    echo '"b" > "a"'
  fi

  echo
  echo ----- File tests

  if [ -a ~/.bash_functions ] || [ -e ~/.bash_functions ]; then
    echo '-a, -e (~/.bash_functions exists)'
  fi

  if [ -f ~/.bash_functions ]; then
    echo '-f (~/.bash_functions exists and is a file)'
  fi

  if [ -h ~/.bash_functions ] || [ -L ~/.bash_functions ]; then
    echo '-h, -L (~/.bash_functions exists and is a symbolic link)'
  fi

  if [ -r ~/.bash_functions ]; then
    echo '-r (~/.bash_functions exists and is readable)'
  fi

  if [ -w ~/.bash_functions ]; then
    echo '-w (~/.bash_functions exists and is writeable)'
  fi

  if [ -O ~/.bash_functions ]; then
    echo '-O (~/.bash_functions exists and is owned by current user)'
  fi

  if [ -x $SHELL ]; then
    echo "-x ($SHELL exists and is executable)"
  fi

  echo
  echo ----- Directory tests

  if [ -d $HOME ]; then
    echo "$HOME exists and is a directory"
  fi

}

function showhidden {
  defaults write com.apple.finder AppleShowAllFiles TRUE
  killall Finder
}

function hidehidden {
  defaults write com.apple.finder AppleShowAllFiles FALSE
  killall Finder
}

function loop {
  for i in 1 2 3 4 5
  do
     echo  -ne "$i"
  done
}

function export_brewed_apps {
  brew list | while read app; do echo "$app"; done > ~/.brewed_apps
}

function reinstall_brewed_apps {
  cat ~/.brewed_apps | while read app; do brew install "$app"; done
}

function brew {
  brew_cmd=`which brew`
  if [ "$1" == "install" ] || [ "$1" == "upgrade" ]; then
      $brew_cmd update
      $brew_cmd "$@"
      $brew_cmd cleanup
      export_brewed_apps
  else
    $brew_cmd "$@"
    if [[ "$1" == "uninstall" ]]; then
      export_brewed_apps
    fi
  fi
}

function git_status_is_clean {
  local status=$(git st)
  if [[ "$status" == *"working directory clean"* ]]; then
    echo "yes"
  else
    echo "no"
  fi
}

function git_status_icon {
  if [[ $(git_status_is_clean) == "yes" ]]; then
    echo "\[$git_clean_color\]✓"
  else
    echo "\[$yellow\]$(modified_file_count)\[$end\]:\[$green\]$(added_file_count)\[$end\]:\[$red\]$(deleted_file_count)\[$end\]\[$git_dirty_color\]"
  fi
}

function modified_file_count {
  count=`git status | grep -o "modified" | wc -l | tr -d ' '`
  echo "$count"
}

function added_file_count {
  count=`git ls-files --others --exclude-standard | wc -l | tr -d " "`
  echo "$count"
}

function deleted_file_count {
  count=`git ls-files --deleted | wc -l | tr -d " "`
  echo "$count"
}

function current_branch {
  echo git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function git_prompt {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    PS1="$(git_status_icon) ${branch}\[$end\] $(repo_prompt)"
  else
    PS1="${prompt}"
  fi
}

function repo_prompt {
  if [[ $PWD == *"Development"* ]]; then
    cprj_path="${PWD/${HOME}\/Development\//}"
  else
    cprj_path="${PWD/${HOME}\//}"
  fi
  echo "\[$prompt_color\]${cprj_path} ❯ \[$end\]"
}

function outdated_formulae_count {
  echo `brew outdated | wc -l | tr -d " "`
}

function render_prompt {
  git_prompt
}

uninstall_gems() {
  list=`gem list --no-versions`
  for gem in $list; do
    gem uninstall $gem -aIx
  done
  gem list
  gem install bundler
}

function colortest {
  T='gYw'

  echo -e "\n                 40m     41m     42m     43m\
       44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}

function server {
  if [ -n "$1" ]; then
    python -m SimpleHTTPServer "$1"
  else
    python -m SimpleHTTPServer 3000
  fi
}

function sublime_repeat {
  if [ -n "$1" ]; then
    if [ "$1" == "enable" ]; then
      defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool false
      echo "Sublime key repeat enabled"
    else
      defaults write com.sublimetext.2 ApplePressAndHoldEnabled -bool true
      echo "Sublime key repeat disabled"
    fi
  fi
}

function notify {
  if [[ -z "$1" ]]; then
    echo "You must provide a message"
  else
    local title="Notification"
    if [[ -n "$2" ]]; then
      title="$2"
    fi
    osascript -e "display notification \"${1}\" with title \"${title}\""
  fi
}
