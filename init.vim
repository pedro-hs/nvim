source $HOME/.config/nvim/src/config.vim
source $HOME/.config/nvim/src/maps.vim
source $HOME/.config/nvim/src/complements.vim
source $HOME/.config/nvim/src/integrations.vim
if !exists('MIN')
    source $HOME/.config/nvim/src/plugins.vim
    source $HOME/.config/nvim/src/extra.vim
endif
