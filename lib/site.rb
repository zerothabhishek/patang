module Patang
  class Site

    attr_accessor :root
    attr_accessor :meta
    attr_accessor :next_post_id
    
    def init
      self.root = FileUtils.pwd
      self.meta = YAML.load_file "_meta"
      self.name = meta["patang"]
      self.next_post_id = meta["next_post_id"]
    end
        
    def update_meta post
    end
      
  end
end