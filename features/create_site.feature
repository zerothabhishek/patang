Feature: Create sites
  As a blogger who wants a fast and simple blog
  I want to be able to make a static site
  In order to protect my ideas from diminishing

  Scenario: Getting started
    Given I have just installed the patang engine
    When I run the command "patang new myblog"
	Then the directory "myblog" should be created
    And the directories\
 		"_site",\
 		"_posts",\
 		"_layouts",\
 		"public/images",\
 		"public/css",\
 		"public/javascripts" should be created 
	And the blog meta file "_meta.yml" should be created in "myblog" directory
	And the layout file "default.html" should be created in "_layouts" directory
	
  Scenario: Creating a new post
	Given I have the patang blog ready
	When I create a new post "first-post.md"
	And I run the command "patang"
	Then the file "first-post.html" should be created in the "_site" directory
	And the file "index.html" should be regenerated
	And the file "_meta.yml" should be appended with the following entry 
	"
	id: 1
		title: first-post
		date: #{Date.today}
		link: first-post.html
	"

  Scenario: Creating a new post with categories
	Given I have the patang blog ready
	When I crete a new post "post-about-ruby"
	And write the front-matter "categories: ruby, programming"
	Then the file "post-about-ruby.html" should be created in "_site" directory
	And the file "index.html" should be regenerated
	And the file "index.html" in the directory "_site/ruby" should be regenerated
	And the file "index.html" in the directory "_site/programming" should be regenerated
	And the file "_meta.yml" should be appended with the following entry
	"
	id: 2
		title: post-about-ruby
		date: #{Date.today}
		link: post-about-ruby.html
		categories: ruby, programming
	"

  Scenario: Creating a new post with title, categories, date, link
	Given I have the patang blog ready
	When I create a new post "a well described post" 
	And write the following front-matter
	"
		title: a well described post
		categories: python
		date: 10 january 2010
		link: a-w-d-p
	"
	Then the file "a-w-d-p.html" should be created in "_site" directory
	And the file "index.html" should be regenerated
	And the file "index.html" in the directory "_site/python" should be regenerated 
	And the file "_meta.yml" should be appended with the following entry
	"
	id: 3
		title: a well described post
		categories: python
		date: 10 january 2010
		link: a-w-d-p
	"
	