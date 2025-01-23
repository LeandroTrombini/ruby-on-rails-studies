# Routing in Rails

# Routing in Rails is the mechanism that connects incoming HTTP requests to the appropriate controller actions.
# It defines the paths and URLs that your application responds to and maps them to specific controller actions.

# Defining Routes

# Routes are defined in the config/routes.rb file. You can define routes using various methods provided by Rails, such as get, post, put, patch, delete, resources, and more.

# Example

# Let's create an example with a UsersController and define some routes for it.

# Step 1: Generate the Controller

# $ rails generate controller Users index show new create edit update destroy

# Step 2: Define Routes

# Define routes for the UsersController in config/routes.rb.

# config/routes.rb
Rails.application.routes.draw do
  # Root route
  root 'users#index'

  # Custom routes
  get 'users', to: 'users#index'
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  # Resourceful routes
  resources :users
end

# Example Usage in Rails Console

# Listing all routes
rails routes

# Output:
# Prefix Verb   URI Pattern            Controller#Action
#  root  GET    /                      users#index
#  users GET    /users(.:format)       users#index
# new_user GET  /users/new(.:format)   users#new
#  user  POST   /users(.:format)       users#create
#  user  GET    /users/:id(.:format)   users#show
# edit_user GET /users/:id/edit(.:format) users#edit
#  user  PATCH  /users/:id(.:format)   users#update
#  user  DELETE /users/:id(.:format)   users#destroy

# Summary

# - Routing in Rails connects incoming HTTP requests to the appropriate controller actions.
# - Define routes in the config/routes.rb file using methods like get, post, put, patch, delete, resources, and more.
# - Use custom routes for specific paths and resourceful routes for standard RESTful actions.
# - Use the rails routes command to list all defined routes in your application.