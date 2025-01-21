# Validations in Rails

# Validations in Rails are used to ensure that only valid data is saved into your database.
# They are defined in the model and are checked at specific moments in an object's lifecycle.

# Common Validations

# - presence: Ensures that a field is not empty.
# - uniqueness: Ensures that a field is unique across the database.
# - length: Ensures that a field has a specific length.
# - numericality: Ensures that a field is a number.
# - format: Ensures that a field matches a specific format.

# Example

# Let's create an example with a User model that has several validations.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string age:integer

# Step 2: Define Validations in the Model

# app/models/user.rb
class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18 }
end

# When Validations are Checked

# Validations are checked at the following moments in an object's lifecycle:

# - Before saving: Validations are checked before an object is saved to the database (both on create and update).
# - Before creating: Validations are checked before a new object is created in the database.
# - Before updating: Validations are checked before an existing object is updated in the database.

# Example Usage in Rails Console

# Creating a valid user
user = User.new(name: 'John Doe', email: 'john.doe@example.com', age: 25)
puts user.valid?  # Output: true
user.save

# Creating an invalid user (missing name)
invalid_user = User.new(email: 'invalid@example.com', age: 25)
puts invalid_user.valid?  # Output: false
puts invalid_user.errors.full_messages  # Output: ["Name can't be blank"]

# Creating an invalid user (invalid email format)
invalid_user = User.new(name: 'Jane Doe', email: 'invalid_email', age: 25)
puts invalid_user.valid?  # Output: false
puts invalid_user.errors.full_messages  # Output: ["Email is invalid"]

# Creating an invalid user (age less than 18)
invalid_user = User.new(name: 'Jane Doe', email: 'jane.doe@example.com', age: 17)
puts invalid_user.valid?  # Output: false
puts invalid_user.errors.full_messages  # Output: ["Age must be greater than or equal to 18"]

# Summary

# - Validations ensure that only valid data is saved into your database.
# - Common validations include presence, uniqueness, length, numericality, and format.
# - Validations are checked before saving, creating, and updating an object.