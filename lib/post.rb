module Patang
  
  class Post 
    attr_accessor :site
    
    def initialize post_file
      read_meta(post_file)
      @post_file_name = File.expand_path(post_file).split('/').last
    end
    
    # read the YAML front matter, and update the post attributes
    #
    def read_meta post_file
      separate_yfm_and_content(post_file)

      @title      = @yfm["title"] 
      @layout     = @yfm["layout"] || @yfm["template"] || "default"
      @permalink  = @yfm["permalink"]
      @datetime   = Time.parse(@yfm["date"]) || File.mtime(post_file)      
    end
    
    # All major processing steps in one method
    #
    def process
      convert
      render
      write
    end
    
    # convert from the markup format post is in, to html
    #
    def convert
      @content = RDiscount.new(@raw_content).to_html
    end
    
    # render the html content within the template
    #
    def render
      layout = File.read "#{site.root}/_layouts/#{@layout}.html"
      @output = Liquid::Template.parse(layout).render('post'=>self)  
    end
    
    # write the output to the _site directory
    #
    def write
      path = "#{site.root}/_site/#{output_file}"
      File.open(path, 'w') do |f|
        f.write(@output)
      end
    end
        
    def to_liquid
      {
        "content"   => @content,
        "title"     => @title,
        "site"      => @site.name,
        "datetime"  => @datetime,
        "date"      => @datetime.strftime("%d"),        # date of the month(01..31)
        "month"     => @datetime.strftime("%b"),        # jan, feb ...
        "year"      => @datetime.strftime("%Y"),        # 1992, 2000 ...
        "day"       => @datetime.strftime("%a"),        # sun, mon ...
        "time"      => @datetime.strftime("%I:%M %p")   # 12 hour time, w/o seconds        
      }
    end
    
    def separate_yfm_and_content post_file
      content_f = File.read post_file                                               # the complete content in the post_file
      yfm_present = (content_f =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m)                # true if YAML front matter is present  
      @raw_content = yfm_present ? content_f[($1.size+$2.size)..-1] : content_f     # YAML front matter is extracted into $1, $2 holds the last line (---) of yfm
      @yfm = YAML.load($1)         
    end
    
    def output_file
      filename = @permalink || @title.gsub(/\s/, '-')
      filename + ".html"
    end
    
    def exists_in_db? 
      !DB[:posts].filter(:post_file=>@post_file_name).empty?
    end
    
    def create_db
      id = DB[:posts].max(:id) + 1 
      DB[:posts].insert(:id => id, :post_file => @post_file_name, :datetime => @datetime, :tags => @tags)
    end
    
    def update_db
      DB[:posts].filter(:post_file => @post_file).update(:datetime => @datetime, :tags => @tags)
    end
    
  end
end
