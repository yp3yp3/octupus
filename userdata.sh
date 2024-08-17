sudo yum install docker -y
sudo service docker start
sudo chkconfig docker on
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo docker run -d -p 2717:27017 -v ~/mongodb:/data/db --name mymongo mongo:latest

