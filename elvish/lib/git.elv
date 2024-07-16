use str

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

fn is_clean_workspace {
  put (str:contains (echo (git status)) 'working tree clean')
}
