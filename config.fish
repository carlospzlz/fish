cat ~/.config/fish/fish.txt

set -x EDITOR vim

function fish_prompt --description 'Write out the prompt'
   set current_branch (git branch ^/dev/null | /usr/bin/grep \* | sed 's/* //')
   set current_branch (set_color brown)"[$current_branch]"(set_color normal)
   set color_cwd (set_color $fish_color_cwd)(prompt_pwd)(set_color normal)
   printf '%s %s@%s %s $ ' "$current_branch" \
                           (whoami) (hostname | cut -d . -f 1) \
                           "$color_cwd"
end
