#!/bin/bash
set -o errexit -o nounset -o pipefail

WEB_DIR="/mnt/sda1/www"
TMP_DIR="/tmp"
LATEST_RELEASE=$(curl --tlsv1.3 https://github.com/vector-im/element-web/releases/latest -s -L -I -o /dev/null -w '%{url_effective}' | grep -Eo '[0-9]+\.[0-9]+\.[0-9][0-9]')
LATEST_RELEASE_CHECK=$(echo $LATEST_RELEASE|sed 's/[^0-9]*//g')
INSTALLED_RELEASE=$(cat $WEB_DIR/element.plus.st/version)
INSTALLED_RELEASE_CHECK=$(echo $INSTALLED_RELEASE|sed 's/[^0-9]*//g')

if (( $LATEST_RELEASE_CHECK > $INSTALLED_RELEASE_CHECK ))
then
	echo "needs updating"
	curl -L --tlsv1.3 https://github.com/vector-im/element-web/releases/download/v$LATEST_RELEASE/element-v$LATEST_RELEASE.tar.gz -o $TMP_DIR/element-v$LATEST_RELEASE.tar.gz
	tar -xpf $TMP_DIR/element-v$LATEST_RELEASE.tar.gz -C /tmp/
	rsync -avi $TMP_DIR/element-v$LATEST_RELEASE $WEB_DIR/element.plus.st/
	rm -rf $TMP_DIR/element-v$LATEST_RELEASE $TMP_DIR/element-v$LATEST_RELEASE.tar.gz
	echo $LATEST_RELEASE | tee $WEB_DIR/element.plus.st/version
	echo "update complete"
else
	echo "already updated"
fi

chmod -R 774 $WEB_DIR
chown -R caddy:www $WEB_DIR/element.plus.st
