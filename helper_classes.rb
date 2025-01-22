# Helper Classes in Rails

# Helper classes in Rails are used to extract complex logic out of views and controllers, making the code cleaner and more maintainable.
# Helpers are typically used to encapsulate view-related logic that can be reused across different views.

# Creating a Helper

# Helpers are defined in the app/helpers directory. Rails automatically generates a helper file for each controller you create.

# Example

# Let's create an example with a UsersController and a helper method to format user names.

# Step 1: Generate the Controller

# $ rails generate controller Users index

# This will create a helper file app/helpers/users_helper.rb.

# Step 2: Define a Helper Method

# Add a helper method to format user names in app/helpers/users_helper.rb.

# app/helpers/users_helper.rb
module UsersHelper
  def format_user_name(user)
    "#{user.name.titleize} (#{user.email})"
  end
end

# Using the Helper in a View

# You can use the helper method in your views to format user names.

# Example

# Render the formatted user names in the index.html.erb view.

# app/views/users/index.html.erb
<h1>Users</h1>
<ul>
  <% @users.each do |user| %>
    <li><%= format_user_name(user) %></li>
  <% end %>
</ul>

# Example Usage in Rails Console

# Creating users
User.create(name: 'john doe', email: 'john.doe@example.com')
User.create(name: 'jane doe', email: 'jane.doe@example.com')

# Accessing the helper method in the console
include UsersHelper
user = User.first
puts format_user_name(user)  # Output: "John Doe (john.doe@example.com)"

# Summary

# - Helper classes are used to extract complex logic out of views and controllers.
# - Helpers encapsulate view-related logic that can be reused across different views.
# - Define helper methods in the app/helpers directory.
# - Use helper methods in views to keep the code clean and maintainable.