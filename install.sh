### RUN
# cd ~/.config
# sudo rm -rf nvim
# git clone https://github.com/pedro-hs/nvim.git
# cd nvim
# sudo sh install.sh && vi -c PlugInstall +qall

sudo apt install silversearcher-ag neovim python3-pip npm

mkdir autoload
cd autoload
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install flake8 isort pylint autopep8 pynvim jedi
npm install --global prettier

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
rm -f DroidSansMono.zip

### AFTER INSTALL
## COMFORTABLE MOTION VIM (change)
# nnoremap <silent> <a-j> :call comfortable_motion#flick(100)<cr>
# nnoremap <silent> <a-k> :call comfortable_motion#flick(-100)<cr>

## BUFTABLINE + DEVICONS (change)
# replace all s:switch_buffer to buftabline#switch_buffer
# let tab.label = tab.path[tab.sep + 1:] . ' ' . WebDevIconsGetFileTypeSymbol(tab.path)

## VIMSPECTOR (run)
# :VimspectorInstall debugpy
# :VimspectorInstall debugger-for-chrome

## VIM VISUAL MULTI (comment)
# autoload/vm.vim
#     call s:V.Funcs.msg('Exited Visual-Multi.')
# autoload/vm/maps.vim
#     call s:V.Funcs.msg('VM has started with warnings. :VMDebug for more info')
# autoload/vm/funcs.vim
#     silent! noautocmd setlocal statusline=%!vm#themes#statusline()

# ALE (comment)
# execute 'echoerr ''The file was changed before fixing finished'''
