# cat ~/.config/fish/fish.txt

# Beautiful colors
set -x TERM xterm-256color

# Open vim and conquer the world.
set -x EDITOR nvim
alias vim "nvim"

set -x BROWSER chromium

# Power grep.
alias grep "grep --color --line-number"
alias egrep "egrep --color --line-number"

# Fish greeting.
function fish_greeting
    fortune
end

# Fish prompt.
function fish_prompt --description 'Write out the prompt'
	if not set -q g_classic_prompt
        set user (string sub -l 3 (whoami))
        set hostname_ (string sub -l 3 (hostname))
		set prompt "$user@$hostname_"
        set -g g_classic_prompt (set_color --bold 778899)"$prompt"(set_color normal)
	end
    set current_branch (git branch ^/dev/null | /usr/bin/grep \* | sed 's/* //')
    set current_branch (set_color brown)"[$current_branch]"(set_color normal)
    set fish_prompt_pwd (set_color "$fish_color_cwd")(prompt_pwd)(set_color normal)
    printf '%s %s %s $ ' "$g_classic_prompt" "$current_branch" "$fish_prompt_pwd"
end

# fzf alias to store fuzzy-found file in environment variable.
function f --description "Open fzf and saves fuzzy-found file in environment"
    set found_file (fzf --preview 'highlight -O ansi {}')
    if [ $found_file ]
        set -g file $found_file
    end
end

# nvim alias to open the last fuzzy-found file.
function v --description "Open in nvim the last fuzzy-found file"
    if [ $file ]
        nvim $file
    else
        echo "no file"
    end
end

# Combination of fzf alias and nvim alias.
function fvim --description "Open the fuzzy-found file in nvim"
    f; v
end

# USD Functional Environments -------------------------------------------------

function usdview --description 'Loads environment variables for USD'
    set USD_ROOT "/usr/local/USD"
    # libGLEW.so.2.0 lives in $USD_ROOT/lib64
    set -x LD_LIBRARY_PATH "$USD_ROOT/lib64"
    set -x PYTHONPATH "$USD_ROOT/lib/python"
    $USD_ROOT/bin/usdview $argv
end

# KATANA Functional Environments ----------------------------------------------

function k --description 'Launches Katana'
    set KATANA_ROOT "/home/infcpl00/foundry/$argv[1]"
    # 3Delight
    set 3DELIGHT_ROOT "/home/infcpl00/foundry/3DelightNSI-2.0.1-Linux-x86_64/3delight/Linux-x86_64"
    set -x LD_LIBRARY_PATH "$3DELIGHT_ROOT/lib"
    set -x PATH "$PATH:$3DELIGHT_ROOT/bin"
    set -x KATANA_RESOURCES "$3DELIGHT_ROOT/3DelightForKatana:$KATANA_RESOURCES"
    # Pxr plug-in shipped with Katana
    set -x PYTHONPATH "$KATANA_ROOT/bin/python/fnUsd"
    set -x KATANA_RESOURCES "$KATANA_ROOT/plugins/Resources/Usd/plugin:$KATANA_RESOURCES"
    set -x LD_LIBRARY_PATH "$KATANA_ROOT/plugins/Resources/Usd/lib:$LD_LIBRARY_PATH"
    # Examples
    set -x KATANA_RESOURCES "$KATANA_ROOT/plugins/Resources/Examples:$KATANA_RESOURCES"
    set -e argv[1]
    $KATANA_ROOT/katana $argv
    set -e PATH[-1]
end

# Apple USDZ tools
function usdzconvert
    set USD_ROOT "/usr/local/USD"
    set -x PYTHONPATH "$USD_ROOT/lib/python:/home/infcpl00/usdpython-0.62/usdzconvert"
	python2 /home/infcpl00/usdpython-0.62/usdzconvert/usdzconvert $argv
end
