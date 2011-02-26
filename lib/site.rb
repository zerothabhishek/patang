module Patang

  class Site

    attr_reader :root
    attr_reader :name
    attr_reader :posts

    def self.this_one meta_path=nil
      self.new(meta_path)
    end
    
    def initialize meta_path=nil
      @root = FileUtils.pwd
      @meta_path = meta_path || "#{root}/_meta.yml"
      @meta = YAML.load_file @meta_path
      @name = @meta["patang"]
    end
    
    def finalize  
    end
    
    # 1. generates _site/index.html
    # 2. generates tag indexes as _site/:tag/index.html
    def generate_indexes
      @posts = DB[:posts].all
      index_layout = File.read "#{root}/_layouts/index.html"
      @output = Liquid::Template.parse(index_layout).render('site'=>self)
      path = "#{root}/_site/index.html"
      File.open(path, 'w'){ |f| f.write(@output) }
    end
    
    def to_liquid
      {
        "name" => @name,
        "posts" => @posts
      }
    end
    
  end
end