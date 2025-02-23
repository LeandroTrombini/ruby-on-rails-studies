# Difference Between delete and destroy in Rails

# In Rails, both delete and destroy are methods used to remove records from the database, but they have different behaviors and use cases.

# delete

# - Behavior: The delete method removes a record from the database without invoking any callbacks or validations. It performs a direct SQL DELETE operation.
# - Use Case: Use delete when you need to quickly remove a record without triggering any associated callbacks or validations.
# - Example:

# app/models/user.rb
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
end

# Deleting a user without invoking callbacks
user = User.find(1)
user.delete

# destroy

# - Behavior: The destroy method removes a record from the database and invokes all the associated callbacks (such as before_destroy and after_destroy) and validations. It performs a SQL DELETE operation after running the callbacks.
# - Use Case: Use destroy when you need to ensure that all associated callbacks and validations are executed before the record is removed.
# - Example:

# app/models/user.rb
class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  before_destroy :log_destroy_action

  private

  def log_destroy_action
    puts "User #{self.id} is about to be destroyed"
  end
end

# Destroying a user and invoking callbacks
user = User.find(1)
user.destroy

# Summary

# - delete: Removes a record from the database without invoking any callbacks or validations. Use for quick deletions without triggering callbacks.
# - destroy: Removes a record from the database and invokes all associated callbacks and validations. Use when you need to ensure callbacks and validations are executed.