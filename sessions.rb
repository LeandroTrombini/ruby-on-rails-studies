# Sessions in Rails

# Sessions in Rails are used to store data between HTTP requests. This allows you to persist user-specific information across multiple requests,
# such as user authentication status, shopping cart contents, or any other data that needs to be retained during a user's session.

# How Sessions Work

# - Session Storage: Rails provides several options for storing session data, including cookies, database, cache, and more.
# - Session ID: Each session is identified by a unique session ID, which is stored in a cookie on the client's browser.
# - Session Data: The session data is stored on the server and can be accessed and modified using the session hash in Rails controllers.

# Example Use Cases for Sessions

# 1. User Authentication: Storing the user's ID to keep them logged in across requests.
# 2. Shopping Cart: Storing the contents of a shopping cart for an e-commerce application.
# 3. Flash Messages: Storing temporary messages that are displayed to the user after a redirect.

# Example

# Let's create an example to demonstrate how to use sessions in Rails for user authentication.

# Step 1: Generate the User Model

# Generate a User model with authentication attributes.

# $ rails generate model User name:string email:string password_digest:string
# $ rails db:migrate

# Add has_secure_password to the User model to handle password hashing and authentication.

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
end

# Step 2: Create the Sessions Controller

# Create a SessionsController to handle user login and logout.

# $ rails generate controller Sessions new create destroy

# Define the actions in the SessionsController.

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end

# Step 3: Add Routes for Sessions

# Add routes for the SessionsController.

# config/routes.rb
Rails.application.routes.draw do
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end

# Step 4: Create the Login Form

# Create a view for the login form.

# app/views/sessions/new.html.erb
<h1>Login</h1>
<%= form_with(url: login_path, local: true) do |form| %>
  <div>
    <%= form.label :email %>
    <%= form.email_field :email %>
  </div>
  <div>
    <%= form.label :password %>
    <%= form.password_field :password %>
  </div>
  <div>
    <%= form.submit 'Login' %>
  </div>
<% end %>

# Step 5: Display Flash Messages

# Display flash messages in the application layout.

# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>MyApp</title>
  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>
  <%= stylesheet_link_tag 'application', media: 'all' %>
  <%= javascript_include_tag 'application' %>
</head>
<body>
  <% if flash[:notice] %>
    <p><%= flash[:notice] %></p>
  <% elsif flash[:alert] %>
    <p><%= flash[:alert] %></p>
  <% end %>
  <%= yield %>
</body>
</html>

# Summary

# - Sessions in Rails are used to store data between HTTP requests.
# - Session data is stored on the server and can be accessed and modified using the session hash in Rails controllers.
# - Use sessions for user authentication, shopping carts, flash messages, and other data that needs to be retained during a user's session.