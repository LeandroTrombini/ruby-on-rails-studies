# Scopes in Rails

# Scopes in Rails are a way to encapsulate commonly used queries into reusable methods.
# They allow you to define custom queries that can be chained with other ActiveRecord methods.

# Example

# Let's create an example with a User model that has several scopes.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string age:integer active:boolean

# Step 2: Define Scopes in the Model

# app/models/user.rb
class User < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :adults, -> { where('age >= ?', 18) }
  scope :by_name, ->(name) { where(name: name) }
end

# Example Usage in Rails Console

# Creating users
User.create(name: 'John Doe', email: 'john.doe@example.com', age: 25, active: true)
User.create(name: 'Jane Doe', email: 'jane.doe@example.com', age: 17, active: false)
User.create(name: 'Alice Smith', email: 'alice.smith@example.com', age: 30, active: true)
User.create(name: 'Bob Johnson', email: 'bob.johnson@example.com', age: 40, active: false)

# Using scopes
active_users = User.active
inactive_users = User.inactive
adult_users = User.adults
johns = User.by_name('John Doe')

# Output results
puts "Active Users: #{active_users.map(&:name).join(', ')}"  # Output: "Active Users: John Doe, Alice Smith"
puts "Inactive Users: #{inactive_users.map(&:name).join(', ')}"  # Output: "Inactive Users: Jane Doe, Bob Johnson"
puts "Adult Users: #{adult_users.map(&:name).join(', ')}"  # Output: "Adult Users: John Doe, Alice Smith, Bob Johnson"
puts "Users named John Doe: #{johns.map(&:name).join(', ')}"  # Output: "Users named John Doe: John Doe"

# Summary

# - Scopes encapsulate commonly used queries into reusable methods.
# - Scopes can be chained with other ActiveRecord methods.
# - Define scopes in the model using the scope method with a lambda.