#!/bin/bash
set -o errexit -o nounset -o pipefail
export WEB_DIR="/mnt/sda1/www"
git -C $WEB_DIR/itzzen.net pull
git -C $WEB_DIR/plus.st pull
chmod -R 774 $WEB_DIR
