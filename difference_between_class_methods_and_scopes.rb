# Class Methods vs Scopes in Rails

# In Rails, both class methods and scopes can be used to define reusable queries.
# However, they have different use cases and syntax.

# Scopes

# Scopes are a way to encapsulate commonly used queries into reusable methods.
# They are defined using the scope method and can be chained with other ActiveRecord methods.

# Example

# Let's create an example with a User model that has several scopes.

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

# Class Methods

# Class methods are defined using the self keyword and can be used to define more complex queries or business logic that may not fit well into a scope.
# They are also more flexible as they can include any Ruby code.

# Example

# Let's create an example with a User model that has several class methods.

# app/models/user.rb
class User < ApplicationRecord
  def self.active
    where(active: true)
  end

  def self.inactive
    where(active: false)
  end

  def self.adults
    where('age >= ?', 18)
  end

  def self.by_name(name)
    where(name: name)
  end
end

# Example Usage in Rails Console

# Creating users
User.create(name: 'John Doe', email: 'john.doe@example.com', age: 25, active: true)
User.create(name: 'Jane Doe', email: 'jane.doe@example.com', age: 17, active: false)
User.create(name: 'Alice Smith', email: 'alice.smith@example.com', age: 30, active: true)
User.create(name: 'Bob Johnson', email: 'bob.johnson@example.com', age: 40, active: false)

# Using class methods
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

# - Scopes: Encapsulate commonly used queries into reusable methods. Defined using the scope method with a lambda.
# - Class Methods: More flexible, can include any Ruby code, and are defined using the self keyword.