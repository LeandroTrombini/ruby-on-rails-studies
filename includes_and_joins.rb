# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :author
end
  
# app/models/author.rb
class Author < ApplicationRecord
  has_many :posts
end
  
  
  
# includes

# The includes method is used to avoid the N+1 queries problem.
# It loads the associations in separate queries and then associates the records in memory.

# Load all posts and their authors in two queries
posts_includes = Post.includes(:author)
posts_includes.each do |post|
  puts "Post: #{post.title}, Author: #{post.author.name}"
end


# joins

# The joins method is used to perform SQL joins between tables.
# It makes a single SQL query that joins the specified tables.

# Load all posts and their authors in a single query
posts_join = Post.joins(:author).where(authors: { name: 'John' })
posts_join.each do |post|
  puts "Post: #{post.title}, Author: #{post.author.name}"
end

# Main differences
# Number of queries:

# includes: Can make multiple queries (one for the main model and another for the associations).
# joins: Makes a single SQL query.

# Purpose:

# includes: Optimize the loading of associations to avoid N+1 queries.
# joins: Perform SQL joins to filter or sort records based on associations.

# Memory usage:

# includes: Can use more memory as it loads all associated records into memory.
# joins: Can be more memory efficient as it performs the join directly in the database.

# Summary

# Use includes when you need to load associations to avoid N+1 queries.
# Use joins when you need to filter or sort records based on associations.