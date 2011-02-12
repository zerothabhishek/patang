module Patang
  class Post
    
    attr_reader :id
    attr_reader :site
    attr_reader :yfm
    attr_reader :raw_content        # the actual content (gross minus meta data)

    attr_accessor :title            
    attr_accessor :time
    attr_accessor :layout           
    attr_accessor :permalink        

    attr_accessor :content          # raw_content.to_html 
    attr_accessor :output           # content + layout html
    
    def initialize post_file, site
      @site = site
      @id = site.next_post_id                  
      
      separate_yfm_and_content(post_file)
         
      self.title      = @yfm["title"] 
      self.layout     = @yfm["layout"] || @yfm["template"] || "default"
      self.permalink  = @yfm["permalink"]
      self.time       = Time.parse(@yfm["date"]) || File.mtime(post_file)
    end

    def output_file
      filename = self.permalink || self.title.gsub(/\s/, '-')
      filename + ".html"
    end
       
    def datetime
      {
        :date     => self.datetime.strftime("%d"),        # date of the month(01..31)
        :month    => self.datetime.strftime("%b"),        # jan, feb ...
        :year     => self.datetime.strftime("%Y"),        # 1992, 2000 ...
        :day      => self.datetime.strftime("%a"),        # sun, mon ...
        :time     => self.datetime.strftime("%I:%M %p")   # 12 hour time, w/o seconds        
      }
    end
              
    def process
      self.convert
      self.render
      self.write
      self.site.next_post_id +=1
    end
    
    # convert from the markup format post is in, to html
    #
    def convert
      self.content = RDiscount.new(self.raw_content).to_html
    end
    
    # render the html content within the template
    #
    def render
      layout = File.read "#{site.root}/_layouts/#{self.layout}.html"
      self.output = Liquid::Template.parse(layout).render('post'=>self)  
    end
    
    # write the output to the _site directory
    #
    def write
      path = "#{site.root}/_site/#{self.output_file}"
      File.open(path, 'w') do |f|
        f.write(self.output)
      end
    end
        
    def to_liquid
      {
        "content"   => self.content,
        "title"     => self.title,
        "site"      => self.site.name,
        "datetime"  => self.time,
        "date"      => self.time.strftime("%d"),        # date of the month(01..31)
        "month"     => self.time.strftime("%b"),        # jan, feb ...
        "year"      => self.time.strftime("%Y"),        # 1992, 2000 ...
        "day"       => self.time.strftime("%a"),        # sun, mon ...
        "time"      => self.time.strftime("%I:%M %p")   # 12 hour time, w/o seconds        
      }
    end
    
    def separate_yfm_and_content post_file
      content_f = File.read post_file                                               # the complete content in the post_file
      yfm_present = (content_f =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m)                # true if YAML front matter is present  
      @raw_content = yfm_present ? content_f[($1.size+$2.size)..-1] : content_f     # YAML front matter is extracted into $1, $2 holds the last line (---) of yfm
      @yfm = YAML.load($1)         
    end
    
  end
end
