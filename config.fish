set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showuntrackedfiles 'yes'
# set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


 function fish_prompt
   set last_status $status
   set_color $fish_color_cwd
   # printf '%s' (prompt_pwd)
   printf '%s' (pwd)
   set_color normal
   printf '%s ' (__fish_git_prompt)
   set_color normal
 end

set FZF_DEFAULT_COMMAND   'fag'
set FZF_CTRL_T_COMMAND    "$FZF_DEFAULT_COMMAND"
set FZF_ALT_C_COMMAND     "$FZF_DEFAULT_COMMAND"

function wd 
  set NEW_DIR (git worktree list | fzf | awk '{print $1}')
  if [ -n "$NEW_DIR" ]; cd $NEW_DIR; end
end

function ff
    ffmpeg -i "$argv" -b:v 1500k -b:a 128k "_$argv"
end

alias vimdiff="vi -d"
alias cbuild="cmake --build ."
alias cinst="cmake --install ."
alias diffuse="python2 /usr/bin/diffuse"
alias stapp="patch -Np 0 < stash.diff"
# alias staff="svn diff > stash.diff"
# alias st="~/favconf/svn-colorstat.py status"
# alias di="svn diff  | colordiff"
alias make="make -j4"
alias g="cd (j -s 1 | head -n -7 | cut -f 2 | tac | fzf)"
alias gw="cd (git worktree list | fzf | sed 's/ .*//')"
alias wl="git worktree list | fzf"
alias ctags="ctags -R --fields=+l --extras=+f --exclude=.gitignore"
alias sdcv="sdcv --color"
alias figr="find . | grep"
alias figa="fa . | grep"
alias ag="ag --vimgrep -p ~/favconf/ag/agignore"
alias fa="ag --nocolor -g '' -p ~/favconf/ag/agignore"
alias rg="rg --vimgrep --ignore-file ~/favconf/ag/agignore"
alias dd="sudo dd bs=64K conv=noerror,sync status=progress"
alias cp="rsync -avh --progress"
alias ls="ls -lhrt --color"
# alias fzf='fzf --preview="head -$LINES {}"'
alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias scp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias pj='python -mjson.tool'
alias op='xdg-open'
alias decolor="perl -pe 's/\x1b\[[0-9;]*m//g'"
alias tac="perl -e 'print reverse <>'"
alias ggre="git pre -2000 | grep " 
#alias find=fd
alias vit="pstree -p | grep -C 6  $fish_pid"
alias ccze="ccze -A"
alias beep="sudo echo -en "\a" > /dev/tty5"
alias mc="mc -S ~/.mc/ini"
alias vi="nvim --listen /tmp/nvimsocket"
alias nano="vi"
alias pacfa="pacman -Ql"
alias ask="opencode run"
alias heb="opencode run 'transalte to hebrew (with niqqud): '"
alias eng="opencode run 'transalte to english: '"
alias rus="opencode run 'transalte to russian: '"
alias du1="du -h -d1 . | sort -hdu -sh"

alias unrarthis='find  ./ -name "*.rar" -type f -exec unrar x {} \;'
alias cbzthis='find  ./ -mindepth 1 -name "*" -type d -exec zip -r {}.cbz {}  \; '
alias rar2cbz="unrarthis && cbzthis  "

# Ctrl Left/Right to move in dir history
bind \e\[1\;5D prevd-or-backward-word
bind \e\[1\;5C nextd-or-forward-word

source /usr/share/autojump/autojump.fish

set VCPKG_ROOT /home/me/.local/share/vcpkg/vcpkg
set PATH $PATH /snap/bin ~/.local/bin $VCPKG_ROOT 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/miniconda3/bin/conda
#     eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
#         . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
#     else
#         # set -x PATH "/opt/miniconda3/bin" $PATH
#     end
# end
# <<< conda initialize <<<

