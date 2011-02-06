module Patang
  
  class Patang
    
    def generate_post post_file_name
      # read the YAML-front matter from the post file
      # update the _meta.yml with the data extracted
      # convert the contents of the file (markdown) into html 
      # render the html within the layout file
      # save the final rendering in _site directory
      # renerate/create the index files
      
      post_file = File.open File.expand_path(post_file_name)
      post_file_content = File.read post_file      
      if post_file_content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        post_file_content = post_file_content[($1.size + $2.size)..-1]
      yaml_front_matter = YAML.load($1)  
      
      meta = YAML.load_file("_meta.yml")
    end
    
    def generate_all
    end
    
    
  end
  
end