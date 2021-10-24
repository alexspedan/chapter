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
cd
cd /home/vagrant/chapter
cp /home/vagrant/chapter/sausage-store.service /etc/systemd/system/sausage-store.service
cp /home/vagrant/chapter/frontend.service /etc/systemd/system/frontend.service
systemctl daemon-reload
systemctl enable sausage-store.service
systemctl start sausage-store.service

systemctl enable frontend.service
systemctl start frontend.service
