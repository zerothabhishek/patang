module Patang
  class Site

    attr_reader :root
    attr_reader :name
    attr_accessor :next_post_id
    
    def initialize
      @root = FileUtils.pwd
      @meta_path = "#{self.root}/_meta.yml"
      @meta = YAML.load_file @meta_path
      @name = @meta["patang"]
      @next_post_id = @meta["next_post_id"]
    end
    
    def next_post_id=id
      @meta["next_post_id"] = id
      YAML.dump(@meta, File.open(@meta_path,'w'))
    end
          
    def finalize  
    end
    
  end
end