use epm

epm:install &silent-if-installed=$true github.com/zzamboni/elvish-modules
epm:install &silent-if-installed=$true github.com/muesli/elvish-libs

# package

# theme
## startship
eval (starship init elvish)

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
  eza --icons=auto --hyperlink --color=always --color-scale=all --color-scale-mode=gradient --git --git-repos $@args
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

var pnpm_home = ~/.local/share/pnpm/
var user_local_path = ~/.local/bin
var user_scripts = ~/scritps/

set paths = [ $pnpm_home $user_local_path $user_scripts $@paths ]
