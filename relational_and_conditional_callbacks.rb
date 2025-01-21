# Relational and Conditional Callbacks in ActiveRecord

# ActiveRecord callbacks are methods that get called at certain points of an object's lifecycle.
# They allow you to add behavior to your models at various stages of the lifecycle, such as before or after saving, creating, updating, or destroying an object.

# Relational Callbacks

# Relational callbacks are used to trigger callbacks on associated objects.
# For example, you might want to trigger a callback on a parent object when a child object is saved.

# Example

# Let's say we have two models: Author and Post.
# When a Post is created, we want to update the updated_at timestamp of the associated Author.

# app/models/author.rb
class Author < ApplicationRecord
  has_many :posts
end

# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :author

  after_save :touch_author

  private

  def touch_author
    author.touch
  end
end

# Conditional Callbacks

# Conditional callbacks are used to execute callbacks only if certain conditions are met.
# You can specify conditions using if or unless options.

# Example

# Let's say we want to send a welcome email to a user only if their email is confirmed.

# app/models/user.rb
class User < ApplicationRecord
  after_create :send_welcome_email, if: :email_confirmed?

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def email_confirmed?
    self.email_confirmed
  end
end

# Summary

# - Relational Callbacks: Trigger callbacks on associated objects.
# - Conditional Callbacks: Execute callbacks only if certain conditions are met.
# - Use after_save, after_create, and other lifecycle callbacks to add behavior to your models.