# Difference Between save and save! in Rails

# In Rails, both save and save! are methods used to persist a model object to the database.
# However, they handle validation failures differently.

# save

# - Behavior: Attempts to save the record and returns true if the record is saved successfully, or false if it fails due to validation errors.
# - Error Handling: Does not raise an exception if the record is invalid.
# - Usage: Use save when you want to handle validation failures gracefully without raising exceptions.

# Example

# app/models/user.rb
class User < ApplicationRecord
  validates :name, presence: true
end

# Example Usage in Rails Console
user = User.new(email: 'john.doe@example.com')
if user.save
  puts 'User saved successfully'
else
  puts 'User could not be saved'
  puts user.errors.full_messages
end

# save!

# - Behavior: Attempts to save the record and returns true if the record is saved successfully.
# - Error Handling: Raises an ActiveRecord::RecordInvalid exception if the record is invalid.
# - Usage: Use save! when you want to ensure that the record is saved successfully and raise an exception if it fails.

# Example

# app/models/user.rb
class User < ApplicationRecord
  validates :name, presence: true
end

# Example Usage in Rails Console
user = User.new(email: 'john.doe@example.com')
begin
  user.save!
  puts 'User saved successfully'
rescue ActiveRecord::RecordInvalid => e
  puts 'User could not be saved'
  puts e.message
end

# Summary

# - save: Attempts to save the record and returns true if successful, or false if it fails due to validation errors. Does not raise an exception if the record is invalid.
# - save!: Attempts to save the record and returns true if successful. Raises an ActiveRecord::RecordInvalid exception if the record is invalid.
# - Use save when you want to handle validation failures gracefully without raising exceptions.
# - Use save! when you want to ensure that the record is saved successfully and raise an exception if it fails.