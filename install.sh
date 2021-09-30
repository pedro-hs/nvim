### RUN
# cd ~/.config
# sudo rm -rf nvim
# git clone https://github.com/pedro-hs/nvim.git
# cd nvim
# sh install.sh && vi -c PlugInstall +qall

sudo apt install -y silversearcher-ag neovim python3-pip npm

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
source ~/.profile
source ~/.bashrc
nvm install 12
nvm use 12

mkdir autoload
cd autoload
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install flake8 isort pylint autopep8 pynvim jedi
sudo npm install --global prettier neovim

### AFTER INSTALL
# ALE (comment)
# execute 'echoerr ''The file was changed before fixing finished'''

# NERDTREE (change in plugged/nerdtree/lib/nerdtree/flag_set.vim)
# return '(' . flagstring . ') '
