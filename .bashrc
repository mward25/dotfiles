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
# Use terminal scrolling
export LESS="-R --mouse --wheel-lines=3"
test -s ~/.alias && . ~/.alias || true

# make x over ssh work
#export DISPLAY=:0.0

# I FOUND THIS AND I THINK IT IS AWESOME, SO I AM GOING TO USE IT
export grep=rg

export GH_EDITOR=nvim

# Generate compile_commands.json
export CMAKE_EXPORT_COMPILE_COMMANDS=1

alias vi="nvim"
alias vim="nvim"
alias nvimdiff='nvim -d'
alias vimdiff='nvimdiff'

alias summr="cat <(echo \"Write a quick summary of the following:\") - | ollama run qwen3:8b --think=false"

export DIFFPROG='nvim -d'

#alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# make commands colorful
alias ls="ls --color=auto --hyperlink=auto"
#alias less="less -r"
#alias grep="grep --color=always"
#alias pdfgrep="pdfgrep --color=always"

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

reflectionate() {
    reflector --sort rate \
        -p \"https,http,ftp\" | \
        sudo tee /etc/pacman.d/mirrorlist
}

#alias dialog="Xdialog"

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


source "$(pkg-config --variable=completionsdir bash-completion)"/git

# If pandoc exists, generate completion
which pandoc &>/dev/null && eval "$(pandoc --bash-completion)"

# Make opengl work better
#export LIBGL_ALWAYS_INDIRECT=0

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


git_prompt_text()
{
    # Set prompt to blue
    #tput setaf 4
    printf "%s " "$(git branch --show-current --omit-empty 2>/dev/null | sed -z 's/\n//g')"

    # Reset prompt colors
    #tput setaf 7
    #tput sgr0
}

get_clock() {
    local current_hour="$(date +'%H')"

    case "$current_hour" in 
         1) printf "󱑋" ;;
         2) printf "󱑌" ;;
         3) printf "󱑍" ;;
         4) printf "󱑎" ;;
         5) printf "󱑏" ;;
         6) printf "󱑐" ;;
         7) printf "󱑑" ;;
         8) printf "󱑒" ;;
         9) printf "󱑓" ;;
        10) printf "󱑔" ;;
        11) printf "󱑕" ;;
        12) printf "󱑖" ;;
        13) printf "󱑋" ;;
        14) printf "󱑌" ;;
        15) printf "󱑍" ;;
        16) printf "󱑎" ;;
        17) printf "󱑏" ;;
        18) printf "󱑐" ;;
        19) printf "󱑑" ;;
        20) printf "󱑒" ;;
        21) printf "󱑓" ;;
        22) printf "󱑔" ;;
        23) printf "󱑕" ;;
        24) printf "󱑖" ;;
    esac

    printf " \\A"
}
get_prompt_text() {
    #local PROMPT_BACKGROUND="\[$(tput setab 8)\]"
    local PROMPT_BACKGROUND=""
    local RESET="\[$(tput sgr0)\]"
    local BRACKET_BACKGROUND="\[$(tput setab 13)\]"
    local OPEN_BRACKET="${BRACKET_BACKGROUND}[${RESET}"
    local CLOSE_BRACKET="${BRACKET_BACKGROUND}]${RESET}"
    #echo -n "${OPEN_BRACKET}${PROMPT_BACKGROUND}$(get_clock) \u@\h \$(git_prompt_text) \w${CLOSE_BRACKET}\n"
    echo -n "${PROMPT_BACKGROUND}"
    echo "$(get_clock) \u@\h"
    echo "  \$(git_prompt_text)" 
    echo -n " \w"
}
get_prompt() {

    #if which boxes 2>/dev/null ; then
    #    echo -n "$(get_prompt_text)" | boxes -d ansi-heavy
    #else
    echo "---"
    echo  "$(get_prompt_text)"
    echo "---"
    #fi
    printf '$ '
}
# Set up prompt
export PS1="$(get_prompt)"


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

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi
