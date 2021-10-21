cat <<EOT > bootstrap.sh
#!/bin/sh

sudo apt upgrade && sudo apt update
sudo apt install default-jre -y
sudo apt install git -y
sudo apt install nodejs -y
sudo apt install openjdk-11-jre-headless -y
mkdir backend
git clone https://github.com/alexspedan/chapter.git
cd /home/vagrant/chapter/frontend
sudo npm install
sudo npm run build
sudo npm install -g http-server
sudo http-server /home/vagrant/frontend -p 80 --proxy http://localhost:8080
cd
cd /home/vagrant/chapter
java -jar sausage-store-0.0.1.jar
