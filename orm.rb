# ORM (Object-Relational Mapping)

# ORM, or Object-Relational Mapping, is a technique that allows you to interact with a relational database using object-oriented programming.
# Instead of writing SQL queries directly, you can use objects and methods to manipulate data in the database.

# Benefits of ORM

# 1. SQL Abstraction: You don't need to write SQL queries directly. Instead, you use methods and objects.
# 2. Productivity: Increases productivity as you work with objects instead of tables and columns.
# 3. Maintenance: Makes code maintenance easier as changes in the database can be reflected in the model classes.
# 4. Security: Reduces the risk of SQL injection as queries are generated by the ORM.

# Example of ORM with ActiveRecord (Rails)

# ActiveRecord is the default ORM for Ruby on Rails. It maps Ruby classes to database tables and object instances to table rows.

# Model Definitions

# app/models/author.rb
class Author < ApplicationRecord
	has_many :posts
end

# app/models/post.rb
class Post < ApplicationRecord
	belongs_to :author
end

# Creating Records

# Creating an author
author = Author.create(name: 'John Doe')

# Creating a post associated with the author
post = Post.create(title: 'My First Post', content: 'Hello, world!', author: author)

# Querying Records

# Finding an author by ID
author = Author.find(1)

# Finding all posts by an author
posts = author.posts

# Finding a post by title
post = Post.find_by(title: 'My First Post')

# Updating Records

# Updating the author's name
author.update(name: 'Jane Doe')

# Updating the post's content
post.update(content: 'Updated content')

# Deleting Records

# Deleting a post
post.destroy

# Deleting an author (and their posts, if configured with dependency)
author.destroy

# Summary

# - ORM: Technique for mapping programming objects to database tables.
# - ActiveRecord: Default ORM for Ruby on Rails.
# - Benefits: SQL abstraction, increased productivity, easier maintenance, and security.
# - Common Operations: Creating, querying, updating, and deleting records using class and instance methods.

# ORM makes working with databases in object-oriented applications easier, making the code cleaner and easier to maintain.