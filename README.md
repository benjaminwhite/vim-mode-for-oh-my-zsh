## vim-mode for Zsh

I made this plugin to replace the inadequate vi-mode plugin which is included in oh my zsh.

Improvements:
* Multilevel undos
* Allows backspacing past where you went into insert mode
* Incremental search (both with '/' and '^R')
* Navigate history with '^P' and '^N' in insert mode
* Stopped weird behavior in vi-mode when escape was pressed multiple times
* Easily edit commands by pressing v in normal mode

Additional Features:
* An experimental feature for iTerm2 on OSX which changes the cursor's shape depending on what mode you are in.  To enable this feature, include "ITERM_CURSOR=true" in your zshrc.
