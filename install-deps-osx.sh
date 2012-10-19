# Install homebrew
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# Install git
brew install git

# Add additional homebrew taps
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

# And install PHP 5.4
brew install josegonzalez/php/composer
brew install josegonzalez/php/php54 