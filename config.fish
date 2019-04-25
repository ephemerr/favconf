set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
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
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

set PATH        ~/projects/hf/reps       $PATH
set PATH        /usr/lib/ccache/bin/     $PATH
set PATH        /usr/lib/colorgcc/bin/   $PATH
set PATH        /home/azzel/.cargo/bin/  $PATH
set CCACHE_PATH       "/usr/bin"
set CCACHE_DIR        "/mnt/fast/ccache"
set VIRTUALENVWRAPPER_PYTHON        /usr/bin/python2
#source /usr/bin/virtualenvwrapper.sh
set JAVA_HOME        /usr/lib/jvm/java-8-openjdk/
set FZF_DEFAULT_COMMAND   'ag --nocolor -g "" -p ~/favconf/ag/agignore'
set FZF_CTRL_T_COMMAND    "$FZF_DEFAULT_COMMAND"
set FZF_ALT_C_COMMAND     "$FZF_DEFAULT_COMMAND"

function wd 
  set NEW_DIR (git worktree list | fzf | awk '{print $1}')
  if [ -n "$NEW_DIR" ]; cd $NEW_DIR; end
end

#alias make="colormake -j4"
alias ctags="ctags -R --extra=+f --exclude=.gitignore"
alias sdcv="sdcv --color"
alias figr="fd . | grep"
alias ag="ag --vimgrep -p ~/favconf/ag/agignore"
alias rg="rg --vimgrep --ignore-file ~/favconf/ag/agignore"
alias locate-docker="locate -d /home/Docker/locate.db"
alias locate-home="locate -d ~/locate.db"
alias dd="sudo dd bs=64K conv=noerror,sync status=progress"
alias cp="rsync -avh --progress"
alias ls="ls -l --color"
alias fzf='fzf --preview="head -$LINES {}"'
alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias scp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias vi=nvim
alias qm54="~/Qt5.4.2/5.4/gcc_64/bin/qmake -r"
alias pj='python -mjson.tool'
alias op='xdg-open'
alias decolor="perl -pe 's/\x1b\[[0-9;]*m//g'"
alias tac="perl -e 'print reverse <>'"
alias wl="git worktree list | fzf"
alias ggre="git pre -2000 | grep " 
alias lfw="ls files/firmware -lart  | sed -r -e 's#.*(BIOSMART.*)#\1#' | tail -1"
alias find=fd
alias vit="pstree -p | grep -C 6  $fish_pid"
alias ccze="ccze -A"
alias beep="echo -en "\a" > /dev/tty5"
