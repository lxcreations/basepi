#!/bin/bash
#when are we
STAMP=$(date +%Y%m%d_%H%M%S)

#where are we
SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#include the baspi config file
source $SOURCEDIR/config/basepi.conf
for file in $(find . -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
    if [ -h ~/$file ]; then
        rm -f ~/$file
    fi
    if [ -e ~/${file}.dtbak ]; then
        mv -f ~/$file{.dtbak,}
    fi
done

#remove cron entries
( crontab -l | grep -v -F "$UPDATESCRIPTBASE" ) | crontab -
( crontab -l | grep -v -F "$BASEPIUPDATESCRIPTBASE" ) | crontab -

#remove basepi config directory
rm -rf ~/.basepi

echo "Uninstalled"
echo "To refresh the bash console, run command"
echo "source ~/.bashrc"