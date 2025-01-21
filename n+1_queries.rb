# N+1 Query Problem in Rails

# The N+1 query problem occurs when an application makes N additional database queries to fetch associated records for each record in a result set.
# This can lead to performance issues due to the large number of queries executed.

# Example of N+1 Query Problem

# Let's create an example with Author and Post models where each author has many posts.

# Step 1: Generate Models

# $ rails generate model Author name:string
# $ rails generate model Post title:string content:text author:references

# Step 2: Define Associations

# app/models/author.rb
class Author < ApplicationRecord
  has_many :posts
end

# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :author
end

# Step 3: Migrate the Database

# $ rails db:migrate

# Step 4: Seed Data

# db/seeds.rb
author1 = Author.create(name: 'Author 1')
author2 = Author.create(name: 'Author 2')

author1.posts.create(title: 'Post 1', content: 'Content 1')
author1.posts.create(title: 'Post 2', content: 'Content 2')
author2.posts.create(title: 'Post 3', content: 'Content 3')
author2.posts.create(title: 'Post 4', content: 'Content 4')

# Example of N+1 Query Problem

# N+1 Query Problem

# Fetching all authors and their posts
authors = Author.all
authors.each do |author|
  puts "Author: #{author.name}"
  author.posts.each do |post|
    puts "  Post: #{post.title}"
  end
end

# This will result in 1 query to fetch all authors and N queries to fetch posts for each author.

# Resolving N+1 Query Problem

# Fetching all authors and their posts with eager loading
authors = Author.includes(:posts)
authors.each do |author|
  puts "Author: #{author.name}"
  author.posts.each do |post|
    puts "  Post: #{post.title}"
  end
end

# This will result in 1 query to fetch all authors and 1 query to fetch all posts.

# Summary

# - The N+1 query problem occurs when an application makes N additional database queries to fetch associated records for each record in a result set.
# - Use the includes method to eager load associated records and resolve the N+1 query problem.