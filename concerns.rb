# Concerns in Rails

# Concerns in Rails are a way to modularize and share code between models, controllers, or other classes.
# They help keep your code DRY (Don't Repeat Yourself) by allowing you to extract common functionality into separate modules that can be included in multiple classes.

# Creating and Using Concerns

# Concerns are typically placed in the app/models/concerns or app/controllers/concerns directory.
# You can create a concern by defining a module and then including that module in the relevant classes.

# Example

# Let's create an example where we have a Trackable concern that adds tracking functionality to multiple models.

# Step 1: Create the Concern

# Create a module in the app/models/concerns directory.

# app/models/concerns/trackable.rb
module Trackable
  extend ActiveSupport::Concern

  included do
    before_create :set_created_at
    before_update :set_updated_at
  end

  def set_created_at
    self.created_at = Time.current
  end

  def set_updated_at
    self.updated_at = Time.current
  end
end

# Step 2: Include the Concern in Models

# Include the Trackable concern in the models that need tracking functionality.

# app/models/user.rb
class User < ApplicationRecord
  include Trackable
end

# app/models/post.rb
class Post < ApplicationRecord
  include Trackable
end

# Example Usage in Rails Console

# Creating a user
user = User.create(name: 'John Doe', email: 'john.doe@example.com')
puts user.created_at  # Output: Current timestamp

# Creating a post
post = Post.create(title: 'My First Post', content: 'Hello, world!')
puts post.created_at  # Output: Current timestamp

# Updating a user
user.update(name: 'Jane Doe')
puts user.updated_at  # Output: Current timestamp

# Summary

# - Concerns are a way to modularize and share code between models, controllers, or other classes.
# - Create a concern by defining a module in the app/models/concerns or app/controllers/concerns directory.
# - Include the concern in the relevant classes using the include keyword.
# - Concerns help keep your code DRY by extracting common functionality into separate modules.