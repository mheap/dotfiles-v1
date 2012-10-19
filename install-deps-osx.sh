# Fix PHP .ini normally
if [ -z "`cat /etc/php.ini | grep 'date.timezone = UTC'`" ]; then
	sudo cp /etc/php.ini.default /etc/php.ini && echo "date.timezone = UTC" | sudo tee -a /etc/php.ini
else
	echo "php.ini already patched"
fi

# Install homebrew
if [ -n "`brew --version 2>/dev/null`" ]; then
	echo "Homebrew is already installed"
else
	ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
fi

# Install git
brew install git

# Add additional homebrew taps
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

# And install PHP 5.4
brew install josegonzalez/php/php54
export PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

# Fix php.ini for 5.4
PHP_INI=`php -i 2>/dev/null| grep "Loaded Configuration File" | awk -F"=> " ' { print $2 } '`
echo "date.timezone = UTC" >> $PHP_INI

# Try and install composer
brew install josegonzalez/php/composer
