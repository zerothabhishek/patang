require 'rubygems'
require 'test/unit'

gem_root = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(gem_root, 'lib')
#$LOAD_PATH << File.join(gem_root, 'lib', 'patang')

require File.join(gem_root, 'lib', 'patang.rb')
