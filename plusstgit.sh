#!/bin/ash
export DIR="$(pwd)"
export GIT="/var/www/localhost/htdocs/plus.st/"

cd $GIT
git pull
cd $DIR
