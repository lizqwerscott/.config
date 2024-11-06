use str

fn branch {
  git rev-parse --abbrev-ref HEAD
}

fn commit_id {
  put (git rev-parse HEAD)
}

fn is_git_repo {
  try {
    and (eq (git rev-parse --is-inside-work-tree 2>/dev/null) 'true') (not (eq (git rev-parse HEAD 2>/dev/null) "0"))
  } catch e {
    put $false
  }
}

fn is_clean_workspace {
  put (str:contains (echo (git status)) 'working tree clean')
}
