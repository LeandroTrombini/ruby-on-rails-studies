# Polymorphic Associations in Rails

# Polymorphic associations in Rails allow a model to belong to more than one other model using a single association.
# This is useful when you have a model that can be associated with multiple other models.

# Example

# Let's create an example with Comment, Post, and Photo models where comments can belong to either posts or photos.

# Step 1: Generate Models

# $ rails generate model Post title:string content:text
# $ rails generate model Photo title:string url:string
# $ rails generate model Comment content:text commentable:references{polymorphic}

# Step 2: Define Models

# app/models/post.rb
class Post < ApplicationRecord
  has_many :comments, as: :commentable
end

# app/models/photo.rb
class Photo < ApplicationRecord
  has_many :comments, as: :commentable
end

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end

# Step 3: Migrate the Database

# $ rails db:migrate

# Example Usage in Rails Console

# Creating a post and a photo
post = Post.create(title: 'My First Post', content: 'Hello, world!')
photo = Photo.create(title: 'My First Photo', url: 'http://example.com/photo.jpg')

# Creating comments for the post and the photo
comment1 = post.comments.create(content: 'Great post!')
comment2 = photo.comments.create(content: 'Nice photo!')

# Querying comments
puts post.comments.map(&:content)  # Output: ["Great post!"]
puts photo.comments.map(&:content)  # Output: ["Nice photo!"]

# Querying the commentable object
puts comment1.commentable.title  # Output: "My First Post"
puts comment2.commentable.title  # Output: "My First Photo"

# Summary

# - Polymorphic associations allow a model to belong to more than one other model using a single association.
# - Define the association in the model using belongs_to with the polymorphic option.
# - Use the as option in the has_many association to specify the polymorphic interface.