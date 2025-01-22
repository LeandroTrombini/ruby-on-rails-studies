# ActiveStorage in Rails

# ActiveStorage is a built-in framework in Rails for handling file uploads.
# It provides a simple and unified way to upload files to cloud storage services like Amazon S3, Google Cloud Storage, and Microsoft Azure Storage, as well as to the local filesystem.

# Setting Up ActiveStorage

# Step 1: Add ActiveStorage to Your Application

# ActiveStorage is included by default in Rails 5.2 and later. To set it up, run the following command to generate the necessary migrations:

# $ rails active_storage:install

# Run the migrations to create the necessary database tables:

# $ rails db:migrate

# Step 2: Configure Storage Service

# Configure the storage service in config/storage.yml. For example, to use the local filesystem in development and Amazon S3 in production:

# config/storage.yml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>

amazon:
  service: S3
  access_key_id: <%= ENV['AWS_ACCESS_KEY_ID'] %>
  secret_access_key: <%= ENV['AWS_SECRET_ACCESS_KEY'] %>
  region: <%= ENV['AWS_REGION'] %>
  bucket: <%= ENV['AWS_BUCKET'] %>

# Set the default storage service in config/environments/development.rb and config/environments/production.rb:

# config/environments/development.rb
config.active_storage.service = :local

# config/environments/production.rb
config.active_storage.service = :amazon

# Using ActiveStorage

# Step 3: Attach Files to Models

# Add file attachments to your models using the has_one_attached or has_many_attached methods.

# app/models/user.rb
class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :documents
end

# Step 4: Upload Files in Forms

# Create a form to upload files.

# app/views/users/_form.html.erb
<%= form_with(model: @user, local: true) do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>

  <%= form.label :avatar %>
  <%= form.file_field :avatar %>

  <%= form.label :documents %>
  <%= form.file_field :documents, multiple: true %>

  <%= form.submit %>
<% end %>

# Step 5: Permit File Parameters in Controller

# Permit the file parameters in the controller.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, documents: [])
  end
end

# Step 6: Display Uploaded Files

# Display the uploaded files in the view.

# app/views/users/show.html.erb
<p>
  <strong>Name:</strong>
  <%= @user.name %>
</p>

<p>
  <strong>Avatar:</strong>
  <%= image_tag @user.avatar if @user.avatar.attached? %>
</p>

<p>
  <strong>Documents:</strong>
  <ul>
    <% @user.documents.each do |document| %>
      <li><%= link_to document.filename, rails_blob_path(document, disposition: "attachment") %></li>
    <% end %>
  </ul>
</p>

# Summary

# - ActiveStorage is a built-in framework in Rails for handling file uploads.
# - Set up ActiveStorage by running the rails active_storage:install command and migrating the database.
# - Configure the storage service in config/storage.yml.
# - Attach files to models using the has_one_attached or has_many_attached methods.
# - Create forms to upload files and permit the file parameters in the controller.
# - Display uploaded files in the view using the image_tag and link_to helpers.