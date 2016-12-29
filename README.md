# ipEmailer
ipEmailer is a utility that will monitor your public ip address and send emails in response to your public ip address changing.  
It requires the user to have a gmail account set up to allow access to applications, with the login information on hand.

## Installation
Run ./setup.sh from the root of the project and respond to the prompts.  
The required files will be stored in the ~/.ipEmailer folder.
To uninstall, simply delete the folder and remove the crontab entry it creates.

## Usage
After installing, add the email addresses you wish messages to be sent to in the ~/.ipEmailer/config/email/emailDestination.config file, one address per line.  
Optionally, you can also customize the email text and title in the emailText.txt and emailTitle.txt files in the same folder.

## Supported platforms
The 'APT' package manager is required for the installation script to work. 
This package manager is installed by default on many Linux distributions, including Debian, Ubuntu and Raspbian.