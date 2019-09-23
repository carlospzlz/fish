function fish_user_key_bindings
  fzf_key_bindings
  # Move words backwards/forwards and kill them.
  bind \cy backward-word
  bind \co forward-word
  bind \cu backward-kill-word
end
