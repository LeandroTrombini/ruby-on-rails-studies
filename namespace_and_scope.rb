# Namespace and Scope Routing in Rails

# In Rails, namespace and scope are used to organize routes and controllers, but they serve different purposes and have different behaviors.

# Namespace Routing

# Namespace routing is used to group related controllers under a common module.
# This is useful for organizing controllers, especially in larger applications.
# It also automatically prefixes the routes with the namespace.

# Example

# Let's create an example with an Admin namespace.

# Step 1: Define Routes

# config/routes.rb
Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end
end

# Step 2: Define Controller

# app/controllers/admin/posts_controller.rb
module Admin
  class PostsController < ApplicationController
    def index
      # Custom logic for listing posts in the admin namespace
    end

    def show
      # Custom logic for showing a post in the admin namespace
    end

    # Other RESTful actions (new, create, edit, update, destroy)
  end
end

# Scope Routing

# Scope routing is used to group routes under a common path prefix without changing the module or controller namespace.
# This is useful for adding a path prefix to routes without changing the controller structure.

# Example

# Let's create an example with a v1 scope for versioning an API.

# Step 1: Define Routes

# config/routes.rb
Rails.application.routes.draw do
  scope :v1 do
    resources :posts
  end
end

# Step 2: Define Controller

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    # Custom logic for listing posts in the v1 scope
  end

  def show
    # Custom logic for showing a post in the v1 scope
  end

  # Other RESTful actions (new, create, edit, update, destroy)
end

# Summary

# - Namespace Routing: Groups related controllers under a common module and prefixes the routes with the namespace.
# - Scope Routing: Groups routes under a common path prefix without changing the module or controller namespace.
# - Use namespace for organizing controllers and adding a module prefix.
# - Use scope for adding a path prefix without changing the controller structure.