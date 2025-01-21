# ActiveRecord Callbacks in Rails

# ActiveRecord callbacks are methods that get called at certain points in an object's lifecycle.
# They allow you to add behavior to your models at various stages, such as before or after saving, creating, updating, or destroying an object.

# Common Callbacks

# - before_validation
# - after_validation
# - before_save
# - after_save
# - before_create
# - after_create
# - before_update
# - after_update
# - before_destroy
# - after_destroy

# Example

# Let's create an example with a User model that uses several callbacks.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string

# Step 2: Define Callbacks in the Model

# app/models/user.rb
class User < ApplicationRecord
  before_validation :normalize_name, on: :create
  before_save :downcase_email
  after_create :send_welcome_email
  before_destroy :log_deletion

  private

  def normalize_name
    self.name = name.split.map(&:capitalize).join(' ') if name.present?
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def send_welcome_email
    # Simulate sending a welcome email
    puts "Sending welcome email to #{email}"
  end

  def log_deletion
    # Simulate logging the deletion
    puts "User #{name} is about to be deleted"
  end
end

# Example Usage in Rails Console

# Creating a user
user = User.create(name: 'john doe', email: 'JOHN.DOE@EXAMPLE.COM')
# Output: Sending welcome email to john.doe@example.com

# Updating a user
user.update(name: 'john smith')
# Output: (no additional output, but email is downcased)

# Destroying a user
user.destroy
# Output: User John Smith is about to be deleted

# Summary

# - ActiveRecord callbacks allow you to add behavior to your models at various stages of an object's lifecycle.
# - Common callbacks include before_validation, after_validation, before_save, after_save, before_create, after_create, before_update, after_update, before_destroy, and after_destroy.
# - Define callbacks in the model using methods like before_validation, before_save, after_create, etc.