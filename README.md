# basepi
Custom setting and basic applications used for Local Fields Ranch Raspberry Pi's

This project was originally created for use on the Raspberry Pi's (RPi's) I use on my Egg Farm and Grow Op, Local Fields Ranch.
With the support of other users, I have decided to make this repo a little more general and friendlier to new RPi users.

Originally, this was only used for dotfiles (like .bashrc) on my Linux based systems and was enspired by [flipsidecreations/dotfiles](https://github.com/flipsidecreations/dotfiles).

This quickly became more than just a repo for dotfiles to include the setup of new RPis with dotfiles, basic applications and custom scripts. Feel free to contant me with any questions or suggestions you may have.

*GIT is a prerequeset for this package to be use as intended.*

To find out if you have git installed, RUN:
```which git```

To install git, RUN:
```sudo apt-get install git```

To install this repo, RUN:
```git clone https://github.com/lxcreations/basepi.git```

**By Default, this should only be used on a Rasberry Pi running Raspbian**
This repo is designed for the Raspberry Pi running Raspbian. It should work on any Raspbian flavor, but it is untested. With little modification, this should be able to be installed on any Debian based system like Ubuntu or KDE Neon. With deeper modification, this could be used on any Linux flavor like OpenSuse or CentOS.


**install.sh** - install all dotfiles and software used on the Raspberry Pi in the users home directory, usually /home/pi
- Install also creates a scripts directory (~/scripts) for you to place custom bash, python, and other scripts. This directory is also placed in the .bashrc as an executable path
- Installs packages if needed
	- git <<  used to get GIT packages/repos
	- sendemail << send email via bash scripts
	- python-pip << install python packages
	- python-pip3 << install python3 packages
	- sysstat << get system status information
	- snmp << monitor with snmp protocol
	- samba << file sharing with Windows, Mac and Linux
		

**uninstall.sh** - removes basepi dotfiles and restores original dotfiles.
- Does not remove installed packages or ~/scripts directory

**Dot Files** - dot files (ie: .bashrc) are usually configuration (config) files used by various applications (bash, vnc, etc)

**.bashrc** - primay config file for the command line terminal
- most notible change is the appearance to be a little easier to use
	
	```
	user@hostname:~$
	```
	*becomes*
	```
	┌─[user@hostname]─[current_working_directory]
	└──╼ $
	```

**.basepi_bash_aliases** - added quick shortcode for common commands.
	- do not modify this file, it will be overwritten when updateing basepi, modify ~/.bash_aliases instead
	- to refresh bash with newly added aliases, run command:
	```
	source ~/.bashrc
	```

**.bash_exports** - set variables for apps and functions for use on the shell

**scripts** - usually bash or python scripts used by cron or user containded in the scripts directory
- this allows for easy organization of scripts and backups of those scripts

**updatenotice.sh** - This is installed in the users crontab to run every Sunday at 1am.
	This script looks to see if there are any updates for the Raspberry Pi and emails you the results
	You must enter your email configuration in ~/.basepi/sendemail.conf for the script to work properly.

**autoupdate.sh** - Script to autoupdate basepi. Read notes/autoupdate.txt for usage


## Raspberry Pi Initial Setup
If you have not already done so, you should run the Raspberry Pi Configuration Tool before install of basepi or any other applications
```
sudo raspi-config
```
- Option 1: Change User password << change to something more familure
- Option 2: Network Options
	- Sub-Option 1: Hostname << set a unique name for the Raspberry Pi
- Option 4: Localisation Options
	- Sub-Option 2: Change Timezone << set to your local timezone
- Option 5: Interfacing Options
	- Sub-Option 2: SSH << enable ssh

These are the bare basics you should need