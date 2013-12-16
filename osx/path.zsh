if [ $BREW_INSTALLED -eq 1 ]; then;
    source `brew --prefix`/etc/profile.d/z.sh
fi

PATH=/usr/local/sbin:/usr/local/bin:$PATH
