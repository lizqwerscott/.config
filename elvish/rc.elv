use epm
use str
use re
use platform

epm:install &silent-if-installed=$true github.com/zzamboni/elvish-modules
epm:install &silent-if-installed=$true github.com/muesli/elvish-libs
epm:install &silent-if-installed=$true github.com/gergelyk/elvish-libs
# package

# theme
## startship
# eval (starship init elvish)

fn -colorized {|what @color|
  if (and (not-eq $color []) (eq (kind-of $color[0]) list)) {
    set color = [(all $color[0])]
  }
  if (and (not-eq $color [default]) (not-eq $color [])) {
    set color = [ $@color bold ]
    styled $what $@color
  } else {
    put $what
  }
}

fn get-env {
  var res = " "

  if (not (eq (which python) '/usr/bin/python')) {
    set res = (str:join '' [' (' (tilde-abbr (str:replace '/bin/python' '' (which python))) ') '])
  }
  put $res
}

var prompt-pwd-dir-length = 1

fn prompt-pwd {
  var tmp = (tilde-abbr $pwd)
  if (== $prompt-pwd-dir-length 0) {
    put $tmp
  } else {
    re:replace '(\.?[^/]{'$prompt-pwd-dir-length'})[^/]*/' '$1/' $tmp
  }
}

# utility functions
# repo status functions
fn branch {
  git rev-parse --abbrev-ref HEAD
}

fn commit_id {
  put (git rev-parse HEAD)
}

fn is_git_repo {
  try {
    eq (git rev-parse --is-inside-work-tree 2>/dev/null) 'true'
  } catch e {
    put $false
  }
}

set edit:prompt = {
  put '╭─'
  -colorized 'Ciallo～(∠・ω< )⌒☆  ' green
  -colorized (str:join '' [ (whoami) '@' (uname -n) ]) blue
  put ' in '
  -colorized (prompt-pwd) yellow
  if (is_git_repo) {
    put ' on '
    put (-colorized (branch) blue)
    if (str:contains (echo (git status)) 'working tree clean') {
    } else {
      put (-colorized '@m' red)
    }
    put '('
    put (-colorized (put (commit_id)[0..8]) red)
    put ')'
  } else {
  }
  put "\n"
  put '╰─'
  -colorized "○ " white
}

set edit:rprompt = {
  put ''
  # $platform:hostname
}

# completions
## carapace-bin
set-env CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
eval (carapace _carapace|slurp)

# keybinding
use readline-binding
{
  var b = {|k f| set edit:insert:binding[$k] = $f }
  $b Ctrl-o $edit:location:start~
}

fn f {
  var data = (fd --type directory | fzf)
  cd $data
}

# utils function
fn ls {|@args|
  eza --icons=auto --color=always --color-scale=all --color-scale-mode=gradient --git --git-repos $@args
}

fn ll {|@args|
  ls -lh $@args
}

fn ra {
  ranger
}

fn lg {
  lazygit
}

fn pwget {|@args|
  proxychains wget $@args
}

fn ff {|@args|
  var tmp = (mktemp -t "yazi-cwd.XXXXX")
  yazi $@args --cwd-file=$tmp
  var cwd = (cat $tmp)
  echo $cwd
  if (and (not (eq cwd "")) (not (eq cwd $pwd)))  {
    cd $cwd
  }
  rm -f $tmp
}

fn ciallo {|n|
  for i [(range 0 $n)] {
    echo "Ciallo～(∠・ω< )⌒☆"
  }
}

# path

var pnpm_home = ~/.local/share/pnpm/
var user_local_path = ~/.local/bin
var user_scripts = ~/scritps/

set paths = [ $pnpm_home $user_local_path $user_scripts $@paths ]

# env
use github.com/gergelyk/elvish-libs/python
var venv~ = $python:venv-activate~
var pyeval~ = $python:pyeval~
