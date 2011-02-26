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
  
  DB = Sequel.connect("sqlite://patang.db")
  
  class Patang
  end

  def self.generate_post post_file
    post = Post.new(post_file)
    post.site = Site.this_one
    post.process    
    post.exists_in_db? ? post.update_db : post.create_db
    site.generate_indexes
  end
  
  def self.generate_index
    site = Site.this_one
    site.generate_indexes
  end      
    
end



# read the YAML-front matter from the post file
# update the _meta.yml with the data extracted
# convert the contents of the file (markdown) into html 
# render the html within the layout file
# save the final rendering in _site directory
# renerate/create the index files
