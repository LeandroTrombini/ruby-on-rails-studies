# Member and Collection Routes in Rails

# In Rails, member and collection routes are used to define custom routes for actions that are not part of the standard RESTful actions (index, show, new, create, edit, update, destroy).

# Member Routes: These routes are used for actions that operate on a single member of the resource. They require an ID.
# Collection Routes: These routes are used for actions that operate on the collection of resources. They do not require an ID.

# Example

# Let's create an example with a Post resource. We'll add custom member and collection routes.

# Step 1: Define Routes

# config/routes.rb
Rails.application.routes.draw do
  resources :posts do
    member do
      get 'preview'
      post 'publish'
    end

    collection do
      get 'archived'
    end
  end
end

# Step 2: Define Controller Actions

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :preview, :publish]

  # GET /posts/:id/preview
  def preview
    # Custom logic for previewing a post
  end

  # POST /posts/:id/publish
  def publish
    # Custom logic for publishing a post
  end

  # GET /posts/archived
  def archived
    # Custom logic for displaying archived posts
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end

# Summary

# - Member Routes: Custom routes for actions on a single member of the resource, requiring an ID.
# - Collection Routes: Custom routes for actions on the collection of resources, not requiring an ID.
# - Define custom routes using the member and collection blocks within the resources block in config/routes.rb.