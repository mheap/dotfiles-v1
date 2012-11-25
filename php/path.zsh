if [ $BREW_INSTALLED -eq 1 ]; then;
    PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
fi

if [ $IS_OSX -eq 0 ]; then;
    PATH="/home/michael/.phpenv/bin:$PATH"
    eval "$(phpenv init -)"
fi
