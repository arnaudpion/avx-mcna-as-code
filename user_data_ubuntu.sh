#! /bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y traceroute iperf iperf3 apache2
sudo apt autoremove
sudo /etc/init.d/ssh restart
sudo systemctl start apache2.service
sudo systemctl enable apache2.service
sudo echo “AVIATRIX ROCKS ! Hello from $(hostname -f)” > /var/www/html/index.html

echo -e "10.10.1.5  aws-prod\n10.10.2.5  aws-dev\n10.10.3.5  aws-shared\n10.10.1.45  jump-prod\n10.10.2.45  jump-dev\n10.10.3.45  jump-shared\n10.20.1.45  azure-prod\n10.20.2.45  azure-dev\n10.20.3.45  azure-shared\n10.30.1.5  gcp-prod\n10.30.2.5  gcp-dev\n10.30.3.5  gcp-shared\n172.16.0.5  on-prem" >> /etc/hosts

cat <<SCR >>/home/ec2-user/cron-ping.sh
#!/bin/sh
ping -c5 aws-prod; echo "ping to aws-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 aws-dev; echo "ping to aws-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 aws-shared; echo "ping to aws-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 azure-prod; echo "ping to azure-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 azure-dev; echo "ping to azure-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 azure-shared; echo "ping to azure-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 gcp-prod; echo "ping to gcp-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 gcp-dev; echo "ping to gcp-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 gcp-shared; echo "ping to gcp-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ping -c5 on-prem; echo "ping to on-prem executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
SCR
chmod +x /home/ec2-user/cron-ping.sh
cat <<SCR >>/home/ec2-user/cron-curl.sh
#!/bin/sh
curl --insecure https://aws-prod; echo "curl to aws-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://aws-dev; echo "curl to aws-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://aws-shared; echo "curl to aws-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://azure-prod; echo "curl to azure-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://azure-dev; echo "curl to azure-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://azure-shared; echo "curl to azure-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://gcp-prod; echo "curl to gcp-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://gcp-dev; echo "curl to gcp-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://gcp-shared; echo "curl to gcp-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
curl --insecure https://on-prem; echo "curl to on-prem executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
SCR
chmod +x /home/ec2-user/cron-curl.sh
cat <<SCR >>/home/ec2-user/cron-ssh.sh
#!/bin/sh
ssh ec2-user@aws-prod; echo "ssh to aws-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@aws-dev; echo "ssh to aws-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@aws-shared; echo "ssh to aws-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh azure-user@azure-prod; echo "ssh to azure-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh azure-user@azure-dev; echo "ssh to azure-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh azure-user@azure-shared; echo "ssh to azure-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@gcp-prod; echo "ssh to gcp-prod executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@gcp-dev; echo "ssh to gcp-dev executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@gcp-shared; echo "ssh to gcp-shared executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
ssh ec2-user@on-prem; echo "ssh to on-prem executed at \$(date)" | sudo tee -a /var/log/traffic-gen.log
SCR
chmod +x /home/ec2-user/cron-ssh.sh
crontab<<CRN
*/5 * * * * /home/ec2-user/cron-ping.sh
*/10 * * * * /home/ec2-user/cron-curl.sh
*/15 * * * * /home/ec2-user/cron-ssh.sh
0 10 * * * rm -f /var/log/traffic-gen.log
CRN
systemctl restart cron
EOF