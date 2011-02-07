module Patang
  
  class Patang
  end

  def self.generate_post post_file
    site = Site.init
    
    post = Post.new(site, post_file)  
    post.convert
    post.render
    
    site.next_post_id += 1
  end    
    
end



# read the YAML-front matter from the post file
# update the _meta.yml with the data extracted
# convert the contents of the file (markdown) into html 
# render the html within the layout file
# save the final rendering in _site directory
# renerate/create the index files
