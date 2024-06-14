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
{
  var b = {|k f| set edit:insert:binding[$k] = $f }
  $b Ctrl-A $edit:move-dot-sol~
  $b Ctrl-B $edit:move-dot-left~
  $b Ctrl-D {
    if (> (count $edit:current-command) 0) {
      edit:kill-rune-right
    } else {
      edit:return-eof
    }
  }
  $b Ctrl-E $edit:move-dot-eol~
  $b Ctrl-F $edit:move-dot-right~
  $b Ctrl-H $edit:kill-rune-left~
  $b Ctrl-L { edit:clear }
  $b Ctrl-N $edit:end-of-history~
  # TODO: ^O
  $b Ctrl-P $edit:history:start~
  # TODO: ^S ^T ^X family ^Y ^_
  $b Alt-b  $edit:move-dot-left-word~
  # TODO Alt-c Alt-d
  $b Alt-f  $edit:move-dot-right-word~
  # TODO Alt-l Alt-r Alt-u

  # Some functionalities bound to Ctrl-$key are occupied by readline binding,
  # use Alt-$key instead.
  $b Ctrl-t $edit:navigation:start~
  $b Ctrl-o $edit:location:start~
  $b Alt-a $edit:apply-autofix~

  # $b Ctrl-t $edit:transpose-rune~
  # $b Alt-t $edit:transpose-word~
}

{
  var b = {|k f| set edit:navigation:binding[$k] = $f }
  $b Ctrl-B $edit:navigation:left~
  $b Ctrl-F $edit:navigation:right~
  $b Ctrl-N $edit:navigation:down~
  $b Ctrl-P $edit:navigation:up~
  $b Alt-f  $edit:navigation:trigger-filter~
}

{
  var b = {|k f| set edit:history:binding[$k] = $f}
  $b Ctrl-N $edit:history:down-or-quit~
  $b Ctrl-P $edit:history:up~
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
