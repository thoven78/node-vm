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
