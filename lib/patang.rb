# stdlib
require 'fileutils'
require 'yaml'
require 'time'

# rubygems
require 'rubygems'

# gems
require 'rdiscount'
require 'liquid'
require 'sequel'

require File.expand_path("../site.rb", __FILE__)
require File.expand_path("../post.rb", __FILE__)

module Patang
  
  class Patang
  end

  def self.generate_post post_file
    site = Site.new
    
    post = Post.filter(:post_file => post_file).first
    post = Post.new(:post_file => post_file)            unless post 
    
    post.site = site
    post.read_meta
    post.convert
    post.render
    post.write
    post.save
    
    site.process_index
  end    
    
end



# read the YAML-front matter from the post file
# update the _meta.yml with the data extracted
# convert the contents of the file (markdown) into html 
# render the html within the layout file
# save the final rendering in _site directory
# renerate/create the index files
