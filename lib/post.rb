module Paatng
  class Post
    
    attr_reader :id
    attr_reader :site
    
    attr_accessor :content          # the actual content (gross minus meta data)
    attr_accessor :meta             # yaml front matter as a hash
    
    def initialize site, post_file
      content_f = File.read post_file                                   # the complete content in the post_file
      yfm_present = (content_f =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m)    # true if YAML front matter is present, 
                                                                        #  and YAML front matter is extracted into $1      
      self.meta = YAML.load($1)   if yfm_present
      self.content = yfm_present ? content_f[($1.size+$2.size)..-1] : content_f
      self.site = site
      self.id = site.next_post_id                  
    end
    
    def convert
      @html = RDiscount.new(self.content).to_html
    end
    
    def render
      
    end
    
  end
end
