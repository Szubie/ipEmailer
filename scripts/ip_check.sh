#!/bin/bash

. inet_check.sh

old_ip=$(cat ~/.ipEmailer/public_ip.txt)
current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

#Check Internet connection first
online=is_online

if [[ $online -eq 'true' ]]; then echo "Online";
    if [[ $old_ip != $current_ip ]]; then
        readarray -t recipients < ~/.ipEmailer/config/email/emailDestination.config
        for recipient in ${recipients[@]}; do
            echo "$(sed "s/CURRENT_IP/$current_ip/g" ~/.ipEmailer/config/email/emailText.txt)" | mail -s "$(sed "s/CURRENT_IP/$current_ip/g" ~/.ipEmailer/config/email/emailTitle.txt)" $recipient
        done
        echo "$current_ip" > ~/.ipEmailer/public_ip.txt
        echo "Your public IP address has changed to: $current_ip"
    else echo "IP unchanged"
    fi
fi
