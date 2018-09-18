#!/bin/bash
#when is this
STAMP=$(date +%Y%m%d_%H%M%S)
#where are we
SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#include the baspi config file
source $SOURCEDIR/config/basepi.conf

#create initial ID variable for OS
ID="unknown"

#include OS details
source /etc/os-release

echo "BasePi install script."
echo "BasePi should only be installed on a Raspberry Pi running Raspian"
echo "Please review the README.md and text files in the notes directory for more details before installing."

while true; do
    read -p "Do you wish to install BasePi? [y/n]: " doinstall
    case $doinstall in
        [Yy]* ) echo "continue"; break;;
        [Nn]* ) echo "exiting"; exit 0;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done

#Install ONLY if we are running Raspian
if [ "$ID" != "raspbian" ]; then
  echo "ERROR: This is only tested with Raspberry Pi's running Raspian."
  echo "Install is exiting."
  # as a bonus, make our script exit with the right error code.
  exit ${1}
fi

#get the current hostname
HOSTNAME=$(hostname)

#create variable for needed installable apps
APTINSTALLS=""

#lets backup the original dot files to restore on uninstall
#and install the basepi dot files
for file in $(find . -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
  if [ -e ~/$file ]; then
    echo "Backup original dotfile: "$file
    if [ ! -h ~/$file ]; then
      mv -f ~/$file{,.dtbak}
    fi
  fi
  if [ ! -e ~/$file ]; then
    echo "Install custom dotfiles: "$file
    cp $file ~/.basepi
    ln -s ~/.basepi/$file ~/$file
  fi
done

echo "Dotfiles installed"
echo ""

#create the scripts directory
if [ ! -d ~/scripts ]; then
    mkdir ~/scripts
    echo "~/scripts directory Created"
fi

#create the basepi local directory
if [ ! -d ~/.basepi ]; then
  mkdir ~/.basepi
  echo "~/.basepi directory created"
fi

#logfiles for basepi
if [ ! -d ~/.basepi/logs ]; then
  mkdir ~/.basepi/logs
  echo "~/.basepi/logs directory created"
fi

#logfiles for basepi
if [ ! -d ~/.basepi/scripts ]; then
  mkdir ~/.basepi/scripts
  echo "~/.basepi/scripts directory created"
fi

#email config for basepi 
if [ ! -e ~/.basepi/sendemail.conf ]; then
    cp $SOURCEDIR/config/sendemail.conf ~/.basepi/sendemail.conf
    echo "~/.basepi/sendemail.conf file created"
    echo "You must modify the sendemail configuration file"
    echo "nano ~/.basepi/sendemail.conf"
fi
echo ""

#if git is not installed, mark it for install
if [ ! -e /usr/bin/git ]; then
    APTINSTALLS="$APTINSTALLS git"
fi

#if pip is not installed, mark it for install
if [ ! -e /usr/bin/pip ]; then
    APTINSTALLS="$APTINSTALLS python-pip"
fi

#if pip3 is not installed, mark it for install
if [ ! -e /usr/bin/pip3 ]; then
    APTINSTALLS="$APTINSTALLS python3-pip"
fi

#if sendemail is not installed, mark it for install
if [ ! -e /usr/bin/sendemail ]; then
    APTINSTALLS="$APTINSTALLS sendemail"
fi

#if sysstat is not installed, mark it for install
if [ ! -e /usr/bin/iostat ]; then
    APTINSTALLS="$APTINSTALLS sysstat"
fi

#if snmp is not installed, mark it for install
if [ ! -e /usr/sbin/snmpd ]; then
    APTINSTALLS="$APTINSTALLS snmpd snmp"
    echo "NOTES:snmpd.txt-Modify /etc/snmp/snmpd.conf for best results of snmp monitoring"
fi

#if samba is not installed, mark it for install
if [ ! -e /usr/sbin/samba ]; then
    APTINSTALLS="$APTINSTALLS samba samba-common-bin"
    echo "NOTES:samba.txt-Modify /etc/samba/smb.conf for best results of file sharing"
fi

echo "These packages need to be installed."
echo $APTINSTALLS

while true; do
    read -p "Would you like to install these packages via apt-get? [y/n]: " doinstall
    case $doinstall in
        [Yy]* )
            echo "installing";
            echo
            if [ "$APTINSTALLS" != "" ]; then
              AGINSLOG=~/.basepi/logs/aptgetoninstall_$(date +%Y%m%d_%H%M%S).log
              sudo apt-get update; sudo apt-get install -yq $APTINSTALLS > $AGINSLOG 2>&1
              echo 
              echo "====================================================================="
              echo "Review $AGINSLOG for install details"
              echo "====================================================================="
              echo 
            fi
            break;;
        [Nn]* ) echo "skipping"; break;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done
#install marked packages and log the install


#install the update notice script in crontab
#SEE notes/updatenotice.txt for details

echo "The Update Notice checks for updates via apt-get and emails you the results."
echo "It is installed as a cronjob to run once a week, Sunday at 1AM."
echo "This only notifies you of updates, it does not install them."
while true; do
    read -p "Would you like to install the Update Notice cron job? [y/n]: " doinstall
    case $doinstall in
        [Yy]* )
            echo "installing";
            echo
            if [ -e /usr/bin/sendemail ]; then
                ( crontab -l | grep -v -F "$UPDATESCRIPT" ; echo "$UPDATECRON" ) | crontab -
            else
                echo "Sendemail package is missing. Cronjob will not be installed."
                echo "RUN: sudo apt-get install sendemail to install"
            fi
            break;;
        [Nn]* ) echo "skipping"; break;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done


#display the current OS
echo "Current OS Version: "$PRETTY_NAME

#inform of installed packages
if [ "$APTINSTALLS" != "" ]; then
  echo "Installed base packages"
  echo $APTINSTALLS
  echo ""
fi

#warn about changing the hostname from original
if [ "$HOSTNAME" = "raspberrypi" ]; then
  echo "NOTES:hostname.txt-Hostname is set as default, you may want to change it to a specific name."
  echo ""
fi

#inform about updating the currently used bash shell
echo "To refresh the bash console, run command"
echo "source ~/.bashrc"
source ~/.bashrc