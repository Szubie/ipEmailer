#!/bin/bash

# This script populates the emailDestination.config file, determining which email addresses will be notified upon a change in ip address.
# The path to the emailDestination.config file is passed as a parameter, $1

echo "" && echo ""
echo "Please enter the email addresses you want to be notified in the event of a change in public ip address, seperated by spaces."
read destinations

echo Your destinations: "$destinations"

for destination in ${destinations[@]}; do
    echo "$destination" | sudo tee -a "$1"
done

echo ""
