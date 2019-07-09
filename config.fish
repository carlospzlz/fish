cat ~/.config/fish/fish.txt

# Open vim and conquer the world.
set -x EDITOR nvim
alias vim "nvim"

# Power grep.
alias grep "grep --color --line-number"
alias egrep "egrep --color --line-number"

# Fish prompt.
function fish_prompt --description 'Write out the prompt'
   set current_branch (git branch ^/dev/null | /usr/bin/grep \* | sed 's/* //')
   set current_branch (set_color brown)"[$current_branch]"(set_color normal)
   set fish_prompt_pwd (set_color "$fish_color_cwd")(prompt_pwd)(set_color normal)
   printf '%s %s $ ' "$current_branch" "$fish_prompt_pwd"
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
   set found_file (fzf --preview 'highlight -O ansi {}')
   if [ $found_file ]
      set -g file $found_file
	  v
   end
end

# Mind the time
alias dclock="/workspace/carlos.perezlopez/github/dclock/dclock \
 -miltime -fg green -bg webgreen"

# KATANA

# Foundry licenses.
set -x FOUNDRY_LICENSE_FILE 30003@mother
set -x foundry_LICENSE 4101@mother

# Developer tools from latest version.
#set -x PATH /workspace/carlos.perezlopez/dev/katana-3.0/Resources/DevTools/bin $PATH
#alias ik "FnKatanaInstaller.py"
#alias k "FnKatanaLauncher.py"
alias mvc "python /workspace/carlos.perezlopez/tools/FnBuildTools/mvc"

# Add custom scripts to PATH
set -x PATH /workspace/carlos.perezlopez/scripts $PATH

# CMake compiled with not C++11 ABI.
#alias cmake "/usr/bin/cmake3"

# Add alacritty binary to PATH.
source ~/.cargo/env

# Make alacritty paly nice with new monitor's DPI
#set -x WINIT_HIDPI_FACTOR 1.2
