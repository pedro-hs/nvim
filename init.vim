source $HOME/.config/nvim/src/config.vim
source $HOME/.config/nvim/src/maps.vim
source $HOME/.config/nvim/src/complements.vim
source $HOME/.config/nvim/src/integrations.vim
if !exists('MINIMAL')
    source $HOME/.config/nvim/src/extra/plugins.vim
    source $HOME/.config/nvim/src/extra/extra.vim
endif
