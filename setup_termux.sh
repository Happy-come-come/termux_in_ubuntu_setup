#!/bin/bash
apt update
yes|apt upgrade -y
apt update
apt install wget proot git vim tar unzip curl zsh -y
cd ~
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git ~/.zsh-completions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh-autosuggestions

#元の環境のrc
curl -Lo ~/.bashrc "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/termux/bashrc"
curl -Lo ~/.zshrc "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/termux/zshrc"

mkdir -p ~/.termux
curl -Lo ~/.termux/CascadiaMono.ttf "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/fonts/CascadiaMono.ttf"
ln -s ~/.termux/CascadiaMono.ttf ~/.termux/font.ttf

echo '大本のtermux環境の構築終了'
git clone https://github.com/MFDGaming/ubuntu-in-termux.git
cd ubuntu-in-termux
chmod +x ubuntu.sh
read -ep "使うバージョンの指定: " dVersion
if [[ "${dVersion}" =~ ^.{3,}$ ]]; then
    sed -ie 's@UBUNTU_VERSION=.*$@UBUNTU_VERSION='${dVersion}'@g' ubuntu.sh
fi
echo "Ubuntuダウンロード中……"
./ubuntu.sh -y
echo "ダウンロード完了"
#ubuntu起動スクリプト
curl -Lo startubuntu_mod.sh "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/termux/startubuntu_mod.sh"
mkdir -p ~/ubuntu-in-termux/ubuntu-fs/home/android
cd ~/ubuntu-in-termux/ubuntu-fs/root
#bashrcにインストールスクリプトを書いて自動で実行させる。
curl -Lo .bashrc "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/ubuntu/setup_bashrc"
cd ~/ubuntu-in-termux/ubuntu-fs/home/android
cp -rf ~/.zsh-completions ~/.zsh-syntax-highlighting ~/.zsh-autosuggestions .
#zshrc
curl -Lo .zshrc "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/ubuntu/zshrc"
#myfunctions
curl -Lo .myfunctions "https://raw.githubusercontent.com/Happy-come-come/termux_in_ubuntu_setup/master/ubuntu/myfunctions"
mkdir -p shellscripts
mkdir -p commands/bin
touch shellscripts/____dummy_.sh

cd ~/ubuntu-in-termux
./startubuntu.sh
chmod +x startubuntu_mod.sh
./startubuntu_mod.sh
