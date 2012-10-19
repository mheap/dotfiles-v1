# Fix PHP .ini normally
if [ -z "`cat /etc/php.ini | grep 'date.timezone = UTC'`" ]; then
	sudo cp /etc/php.ini.default /etc/php.ini && echo "date.timezone = UTC" | sudo tee -a /etc/php.ini
else
	echo "php.ini already patched"
fi
