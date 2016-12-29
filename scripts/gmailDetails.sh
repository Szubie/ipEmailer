#!/bin/bash

# This script overwrites the default USERNAME and PASSWORD entries in the sasl_passwd file.
# The path to the sasl_passwd file is passed as a parameter, $1

echo "" && echo ""
echo "Please enter your gmail email address in full (e.g. test@gmail.com)"
read email

echo "Please enter your email password (it is recommended to generate an app password)"
read password

echo "Your email: $email"
echo "Your password: $password"

sed -i "s/USERNAME/$email/g" $1
sed -i "s/PASSWORD/$password/g" $1