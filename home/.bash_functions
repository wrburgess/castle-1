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
  open -a Airmail
  open -a localhost:300 -a "Google Chrome"
  project
  if [[ -n "$1" ]]; then
    $($1 .)
  else
    s .
  fi
}

function bundle {
  bundler_cmd=`which bundle`
  if [ -z "$1" ] || [ "$1" == "install" ]; then
    if [ ! -d ./.bundle/bin ]; then
      $bundler_cmd --binstubs .bundle/bin
    else
      $bundler_cmd
    fi
  else
    $bundler_cmd "$@"
  fi
  rbenv rehash
}

function gem {
  gem_cmd=`which gem`
  $gem_cmd "$@"
  rbenv rehash
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
    git pull origin master
  fi
}

function push {
  if [ -n "$1" ]; then
    git push origin "$1"
  else
    git push origin master
  fi
}

function rs {
  if [ -n "$1" ]; then
    rspec spec/"$1"_spec.rb
  else
    rspec spec
  fi
}

function s {
  if [ -n "$1" ]; then
    open "$1" -a "Sublime Text 2"
  else
    open "./" -a "Sublime Text 2"
  fi
}

function e {
  if [ -n "$1" ]; then
    open "$1" -a "Emacs"
  else
    open "./" -a "Emacs"
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
    file=$(basename $1)

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

function loop {
  for i in 1 2 3 4 5
  do
     echo  -ne "$i"
  done
}