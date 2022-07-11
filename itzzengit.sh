#!/bin/ash
export DIR="$(pwd)"
export GIT="/var/www/localhost/htdocs/itzzen.net/"

cd $GIT
git pull
cd $DIR
