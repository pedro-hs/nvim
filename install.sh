### RUN
# cd ~/.config
# sudo rm -rf nvim
# git clone https://github.com/pedro-hs/nvim.git
# cd nvim
# sh install.sh && vi -c PlugInstall +qall

sudo apt install -y silversearcher-ag neovim python3-pip npm feh

mkdir autoload
cd autoload
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install flake8 isort pylint autopep8 pynvim jedi
sudo npm install --global prettier

### AFTER INSTALL
## COMFORTABLE MOTION VIM (add)
# nnoremap <silent> <a-j> :call comfortable_motion#flick(100)<cr>
# nnoremap <silent> <a-k> :call comfortable_motion#flick(-100)<cr>

# ALE (comment)
# execute 'echoerr ''The file was changed before fixing finished'''

# NERDTREE (change in plugged/nerdtree/lib/nerdtree/flag_set.vim)
# return '(' . flagstring . ') '
