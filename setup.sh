#!/bin/bash

chmod +x scripts/*

# Create local folder
mkdir ~/.ipEmailer
cp scripts/ip_check.sh ~/.ipEmailer
cp scripts/inet_check.sh ~/.ipEmailer
cp config/public_ip.txt ~/.ipEmailer
cp -r config ~/.ipEmailer

# Get user details
scripts/gmailDetails.sh ~/.ipEmailer/config/sasl_passwd
scripts/destinationAddresses.sh ~/.ipEmailer/config/email/emailDestination.config

echo "Installing necessary software"
 
sudo apt-get update

# Configure postfix
sudo debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y postfix mailutils libsasl2-2 ca-certificates libsasl2-modules

# Configure the settings for gmail
cat config/smtp.config | sudo tee -a /etc/postfix/main.cf

# Use the user's email details
sudo cp ~/.ipEmailer/config/sasl_passwd /etc/postfix
sudo chmod 400 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd

cat /etc/ssl/certs/thawte_Primary_Root_CA.pem | sudo tee -a /etc/postfix/cacert.pem
sudo /etc/init.d/postfix reload
sudo service postfix restart

echo "Setting up regular IP_checks"
crontab -l | { cat; echo "0 * * * * ~/.ipEmailer/ip_check.sh"; } | crontab -

# Set the initial ip address
current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "$current_ip" > ~/.ipEmailer/public_ip.txt

echo "Your public IP address is: $current_ip. You will be notified by email if it changes."