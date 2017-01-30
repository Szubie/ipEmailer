#!/bin/bash

old_ip=$(cat ~/.ipEmailer/public_ip.txt)
current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

#Check Internet connection first
inet=$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo Online || echo Offline)

if [[ $inet == 'Online' ]]; then echo $inet;
    if [[ $old_ip != $current_ip ]]; then
        readarray -t recipients < /opt/ipEmailer/config/email/emailDestination.config
        for recipient in ${recipients[@]}; do
            echo "$(sed "s/CURRENT_IP/$current_ip/g" ~/.ipEmailer/config/email/emailText.txt)" | mail -s "$(sed "s/CURRENT_IP/$current_ip/g" ~/.ipEmailer/config/email/emailTitle.txt)" $recipient
        done
        echo "$current_ip" > ~/.ipEmailer/public_ip.txt
        echo "Your public IP address has changed to: $current_ip"
    else echo "IP unchanged"
    fi
fi

