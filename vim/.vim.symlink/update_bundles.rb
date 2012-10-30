#!/usr/bin/env ruby

# shamelessly stolen from https://github.com/tsaleh/dotfiles/blob/master/vim/update_bundles
git_bundles = %w{
    git://github.com/altercation/vim-colors-solarized.git
    git://github.com/Lokaltog/vim-easymotion.git
    git://github.com/myusuf3/numbers.vim.git
    git://github.com/scrooloose/nerdtree.git
}

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

