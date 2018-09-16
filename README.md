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

**By Default, this should only be used on a Rasberry Pi running Raspian**
This repo is designed for the Raspberry Pi running Raspian. It should work on any Raspian flavor, but it is untested. With little modification, this should be able to be installed on any Debian based system like Ubuntu or KDE Neon. With deeper modification, this could be used on any Linux flavor like OpenSuse or CentOS.


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
		

**uninstall.sh** - remove custom dotfiles and restore originals.
- Does not remove installed packages or ~/scripts directory
