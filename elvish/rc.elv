# package
use github.com/zzamboni/elvish-modules/alias
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/dd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh


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
