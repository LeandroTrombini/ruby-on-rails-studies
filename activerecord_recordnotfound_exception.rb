# Handling ActiveRecord::RecordNotFound Exception for All Resources in Rails

# To handle the ActiveRecord::RecordNotFound exception globally for all resources in a Rails application,
# you can use a rescue_from statement in your ApplicationController.
# This will ensure that the exception is caught and handled gracefully, providing a consistent user experience.

# Example

# Let's create an example to demonstrate how to handle the ActiveRecord::RecordNotFound exception for all resources.

# Step 1: Define the Exception Handling in ApplicationController

# Add a rescue_from statement in the ApplicationController to catch the ActiveRecord::RecordNotFound exception
# and handle it by rendering a custom 404 page or redirecting to a specific action.

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end

# Example Usage in a Controller

# Let's create a UsersController to demonstrate how the exception handling works.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end

# Example Usage in Rails Console

# Trying to find a user that does not exist
begin
  User.find(999)
rescue ActiveRecord::RecordNotFound => e
  puts e.message  # Output: Couldn't find User with 'id'=999
end

# Summary

# - Use the rescue_from statement in the ApplicationController to handle the ActiveRecord::RecordNotFound exception globally.
# - Define a private method to handle the exception, such as rendering a custom 404 page or redirecting to a specific action.
# - This approach ensures that the exception is caught and handled gracefully, providing a consistent user experience.