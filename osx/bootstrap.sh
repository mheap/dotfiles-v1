# Install homebrew
if [ -n "`brew --version 2>/dev/null`" ]; then
	echo "Homebrew is already installed"
else
	ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
fi

# Install git
brew install git

# Install wget
brew install wget

# Add additional homebrew taps
brew tap homebrew/dupes
brew tap homebrew/homebrew-php

# And ack
brew install ack

# And autoconf (for phpize)
brew install autoconf

# How about mysql?
brew install mysql

# We need ctags for vim
brew install ctags

# Also ag for bim
brew install the_silver_searcher

# Coreutils!
brew install coreutils

# Youtube-dl stuff, needed for to-mp3
brew install youtube-dl
brew install ffmpeg

# Install Z
brew install Z

# And install PHP 5.6
brew install php56
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

# Fix php.ini for 5.6
PHP_INI=`php -i 2>/dev/null| grep "Loaded Configuration File" | awk -F"=> " ' { print $2 } '`
echo "date.timezone = UTC" >> $PHP_INI
