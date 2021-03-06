echo 'Get updates...'
sudo apt-get update

echo 'Installing python and pip...'
sudo apt-get -y install python-pip python-dev

echo 'Remove outdated packaging...'
sudo apt-get autoremove

echo 'Installing ansible...'
sudo pip install ansible

echo 'Installing build-essential...'
sudo apt-get install build-essential

echo 'Installing git-prompt...'
curl -o /home/vagrant/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

echo 'Installing dependencies in setup.yml...'
ansible-playbook -i 127.0.0.1, -c local /home/vagrant/ansible/setup.yml

# sudo apt-get install oracle-java7-installer
echo 'Installing Java 7...'
sudo apt-get -y install openjdk-7-jre-headless

# Setting Environment Varaibles
echo 'Setting environment variables...'
echo 'export NODE_ENV=development' >> /home/vagrant/.bashrc
#echo '\ncd /vagrant' >> /home/vagrant/.bashrc
# Installing nvm
echo 'Installing nvm...'
export HOME=/home/vagrant
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
echo 'source ~/.nvm/nvm.sh' >> /home/vagrant/.bashrc
source /home/vagrant/.nvm/nvm.sh
echo 'Realing .bashrc'
source /home/vagrant/.bashrc
echo 'Changing the ownership of .nvm to vagrant...'
chown -R vagrant:vagrant /home/vagrant/.nvm
export HOME=/home/root
# Installing NPM packages
echo 'Installing NPM packages...'
echo 'PATH=$PATH:/vagrant/node_modules/.bin' >> /home/vagrant/.bashrc
PATH=$PATH:/vagrant/node_modules/.bin
cd /home/vagrant && rm -rf node_modules
[ -f package.json ] && npm install

# Installing Node.JS
echo 'Installing Node.JS...'

nvm install node
echo 'Use the lastest version of Node'

nvm alias default stable

echo 'Fixing nvm ls-remote...'
sed -i 's/curl -q $*/curl -k $/' .nvm/nvm.sh

echo 'Update nvm permision...'
# Because we changed the nvm.sh file we have to update the permision
sudo chown -R vagrant:vagrant /home/vagrant/.nvm

echo 'Setting TimeZone...'
export tz=`wget -qO - http://geoip.ubuntu.com/lookup | sed -n -e 's/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p'` &&  timedatectl set-timezone $tz
export tz=`timedatectl status| grep Timezone | awk '{print $2}'`
echo 'TimeZone set to $tz'
