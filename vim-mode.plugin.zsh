# vim-mode.plugin.zsh
#
# Author: Ben White
# URL: benjaminwhite.info

bindkey -v

# Multi-level undo
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

# Allow backspacing past where you started in insert mode
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Incrememntal search
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward

# Allow Ctrl-P and Ctrl-N in insert mode
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Edit in vim
bindkey -M vicmd v edit-command-line

# Allow in
#bindkey -M vicmd 'ciw' 'bcw'
#bindkey -M vicmd 'diw' 'bdw'

# Stop weird behavior when hitting escape multiple times
noop () {}
zle -N noop
bindkey -M vicmd '\E' noop

# Changes cursor shape depending on mode
if [ "$ITERM_CURSOR" = "true" ]; then

    BLOCK='\E]50;CursorShape=0\x7' # Block Cursor
    LINE='\E]50;CursorShape=1\x7' # Line Cursor
    BAR='\E]50;CursorShape=2\x7' # Bar Cursor
    
    print-ins () {
        if [ $TERM = screen-256color ]; then
            print -n -- "\EPtmux;\E$LINE\E\\"
        else
            print -n -- $LINE
        fi
    }

    print-cmd () {
        if [ $TERM = screen-256color ]; then
            print -n -- "\EPtmux;\E$BLOCK\E\\"
        else
            print -n -- $BLOCK
        fi
    }

    zle-keymap-select () {
        if [ $KEYMAP = vicmd ]; then
            print-cmd
        elif [ $KEYMAP = main ]; then
            print-ins
        fi
    }

    zle-line-init () {
        print-ins
    }

    zle -N print-ins
    zle -N print-cmd
    zle -N zle-line-init
    zle -N zle-keymap-select

    # Turns on focus reporting 
    print -n -- '\E[?1004h'

    # Binds the escape sequences to change cursor accordingly. 
    bindkey -M vicmd '\E[I' print-cmd
    bindkey -M vicmd '\E[O' noop
    bindkey -M viins '\E[I' print-ins
    bindkey -M viins '\E[O' noop
fi
