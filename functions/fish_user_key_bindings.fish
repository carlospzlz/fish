function fish_user_key_bindings
    fzf_key_bindings

    # Be nimble
    bind \cy backward-bigword
    bind \co forward-bigword
    bind \cu beginning-of-buffer
    bind \c_ backward-kill-bigword
end
