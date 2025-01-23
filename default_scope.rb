# default_scope in Rails

# The default_scope method in Rails allows you to define a default set of conditions that will be applied to all queries for a particular model.
# This can be useful for applying common filters or ordering to all queries for a model.

# Example

# Let's create an example with a User model where we use default_scope to order users by their created_at timestamp in descending order.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string created_at:datetime
# $ rails db:migrate

# Step 2: Define the default_scope

# Define the default_scope in the User model to order users by created_at in descending order.

# app/models/user.rb
class User < ApplicationRecord
  default_scope { order(created_at: :desc) }
end

# Example Usage in Rails Console

# Creating users
User.create(name: 'John Doe', email: 'john.doe@example.com', created_at: 1.day.ago)
User.create(name: 'Jane Doe', email: 'jane.doe@example.com', created_at: 2.days.ago)
User.create(name: 'Alice Smith', email: 'alice.smith@example.com', created_at: Time.current)

# Querying users
users = User.all
users.each do |user|
  puts "#{user.name} - #{user.created_at}"
end

# Output:
# Alice Smith - Current timestamp
# John Doe - 1 day ago
# Jane Doe - 2 days ago

# Summary

# - The default_scope method allows you to define a default set of conditions that will be applied to all queries for a particular model.
# - Use default_scope to apply common filters or ordering to all queries for a model.
# - Define the default_scope in the model using the default_scope method with a block.