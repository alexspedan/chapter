cat <<EOT > bootstrap.sh
#!/bin/sh

sudo -i
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
echo 'options edns0' >> /etc/resolv.conf
apt upgrade && sudo apt update
apt install default-jre -y
apt install git -y
apt install nodejs -y
apt install openjdk-11-jre-headless -y
mkdir backend
git clone https://github.com/alexspedan/chapter.git
cd /home/vagrant/chapter/frontend
npm install
npm run build
npm install -g http-server
http-server /home/vagrant/frontend -p 80 --proxy http://localhost:8080
cd
cd /home/vagrant/chapter
java -jar sausage-store-0.0.1.jar
