# Thoughts on `patang` blogging engine

## The engine should have/do -

## ACL & meta-date

- Can be a two files -
	private_ACL		:	List(post-link)
	protected_ACL	:	List(post-link, password)
- server side read only.

- meta-data in sqlite database


21 feb 2010

wtf - if you make a class a model using Sequel, you can't have the initialize method in it.

25feb2010
# schema :
#   id          PrimaryKey
#   post_file   String
#   datetime    DateTime (Time)
#   tags        String

