#!/usr/bin/env ruby

# shamelessly stolen from https://github.com/tsaleh/dotfiles/blob/master/vim/update_bundles
git_bundles = [

    ## Colourschemes
    "git://github.com/altercation/vim-colors-solarized.git", 
    
    ## Plugins
    "git://github.com/Lokaltog/vim-easymotion.git", # Quick navigation inside a buffer
    "git://github.com/myusuf3/numbers.vim.git", # Relative line numbers in normal mode
    "git://github.com/scrooloose/nerdtree.git", # Tree file viewer
    "git://github.com/vim-scripts/LustyJuggler.git", # Buffer manager
    "git://github.com/kien/ctrlp.vim.git", # Fuzzy matching file opener

    ## Syntax files
    "git://github.com/tpope/vim-markdown.git", # Markdown syntax
    "git://github.com/pangloss/vim-javascript.git" # Better Javascript indentation
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.rm_rf(bundles_dir)
FileUtils.mkdir(bundles_dir)
FileUtils.cd(bundles_dir)

git_bundles.each do |url|
  puts url
  `git clone -q #{url}`
end

Dir["*/.git"].each {|f| FileUtils.rm_rf(f) }
