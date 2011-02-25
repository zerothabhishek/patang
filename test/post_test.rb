require 'test_helper'
require 'mocha'

class TestPost < Test::Unit::TestCase
  
  def setup
    f = File.open("temp001","w")
    f.write content
    f.close
  end
  
  def test_new
    Patang::Site.stubs(:new).returns(:true)
    p = Patang::Post.new "temp001", Patang::Site.new
    assert false, p.yfm.nil? 
    assert false, p.raw_content.nil?
  end
  
  def content
  content = <<-END_OF_FILE
---

layout: post
title: the blog post title
date: 11 feb 2011
location: Bangalore

---

The first blog post.
__this is bold__.
_this one is italic_.

END_OF_FILE
  end
  
end

