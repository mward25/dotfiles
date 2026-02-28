# For GPG Keys
GPG_TTY=`tty`
export GPG_TTY
# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export PAGER=less
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=kitty
export PGDATA=/var/lib/postgres/data
# Use elk layout engine for d2 graphs
export D2_LAYOUT=elk
export MOZ_ENABLE_WAYLAND=1

export PATH=$PATH:~/bin:~/.local/bin:/opt/google-cloud-cli/bin
export TESSDATA_PREFIX=/usr/share/tessdata/
test -s ~/.alias && . ~/.alias || true

# make x over ssh work
#export DISPLAY=:0.0

# I FOUND THIS AND I THINK IT IS AWESOME, SO I AM GOING TO USE IT
export grep=rg

export GH_EDITOR=vim

# Generate compile_commands.json
export CMAKE_EXPORT_COMPILE_COMMANDS=1

alias vi=nvim
alias vim=nvim

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# make commands colorful
alias ls="ls --color=auto --hyperlink=auto"
#alias less="less -r"
alias grep="grep --color=always"
alias pdfgrep="pdfgrep --color=always"

# Makes my stupid ls typos still work
alias l="ls -al"
alias la="ls -al"
alias ll="ls -l"
alias sl="ls"
alias lls="ls"
alias sls=ls
alias slsl=ls
alias lss=ls
alias lssl=ls

alias s="kitten ssh"

alias update_mirros="reflector --sort rate -p \"https\" | sudo tee /etc/pacman.d/mirrorlist"

alias dialog="Xdialog"

alias png2spritesheetH="convert *.png +append "
alias png2spritesheetV="convert *.png -append "

alias startMyDrive="rclone mount drive: ~/drive/mine &"
alias startSharedDrive="rclone mount drive: --drive-shared-with-me  ~/drive/shared &"
alias mountDrives="startMyDrive ; startSharedDrive"

alias clip="kitten clipboard"

alias gdiff="git difftool --no-symlinks --dir-diff"

# if the ARC vairiable is not set, set it to x86_64
if [ -z "$ARC" ]
then
    export ARC="x86_64"
    if [ -z "$arc"]
    then
        export arc=$ARC
    fi
fi

# if [ $TERM == "xterm-kitty" ]
# then
#     alias vim="vim -T kitty "
# fi

. /usr/share/bash-completion/completions/git

# If pandoc exists, generate completion
which pandoc &>/dev/null && eval "$(pandoc --bash-completion)"

# Make opengl work better
export LIBGL_ALWAYS_INDIRECT=0

# Make it so tab complete does not ring bell
if [[ $- = *i* ]]; then
    bind "set bell-style none"
fi

#PATH="/home/miles/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/miles/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/miles/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/miles/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/miles/perl5"; export PERL_MM_OPT;

[ -f ~/bin/timew_bash_complete_activate.sh ] && ~/bin/timew_bash_complete_activate.sh*

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


prompt_text()
{
    # Set prompt to blue
    #tput setaf 4
    printf "{"
    git branch --show-current --omit-empty 2>/dev/null | sed -z 's/\n//g'  
    printf "}"
    # Reset prompt colors
    #tput setaf 7
    #tput sgr0
}

task_prompt()
{
    export TASK="task"
    #printf "$(task +READY +DUETODAY count):$(task +READY count)"
    #if [ `$TASK +READY +OVERDUE count` -gt "0" ]; then
    #    printf "💀 "
    #elif [ `$TASK +READY +DUETODAY count` -gt "0" ]; then
    #    printf "❶ "
    #elif [ `$TASK +READY +TOMORROW count` -gt "0" ]; then
    #    printf "❷ "
    #elif [ `$TASK +READY urgency \> 10 count` -gt "0" ]; then
    #    printf "🤯"
    #else
    #    printf "$"
    #fi
}

# Set up prompt
export PS1='\A \u@\h $(prompt_text) \w $ '


# Configure themes
## Use native file browser in firefox
#export GTK_USE_NATIVE_PORTAL=1
#export GTK_THEME=~/.themes/Gruvbox-Dark/
#export GTK2_RC_FILES=~/.themes/Gruvbox-Dark/gtk-2.0
#export GTK2_RC_FILES="/usr/share/themes/catppuccin-macchiato-lavender-standard+default"
#export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
#export GTK_THEME=Adwaita:dark
#export QT_STYLE_OVERRIDE=kvantum
#export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc

# Ensure .bash_history is never truncated
export HISTFILESIZE=
export HISTSIZE=

# OpenClaw Completion
source "/home/miles/.openclaw/completions/openclaw.bash"
