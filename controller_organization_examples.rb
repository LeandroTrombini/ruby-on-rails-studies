# Organizing Controllers in Rails

# In Rails, controllers are responsible for handling incoming HTTP requests, processing them, and returning appropriate responses.
# To keep controllers organized and maintainable, it's important to follow best practices and design patterns that help keep controllers thin and focused.

# Best Practices for Organizing Controllers

# 1. Follow RESTful Conventions
# 2. Use Strong Parameters
# 3. Extract Business Logic to Models or Services
# 4. Use Concerns for Shared Code
# 5. Use Callbacks Wisely
# 6. Paginate Large Collections

# Example

# Let's create an example to demonstrate how to organize controllers and keep them thin.

# Step 1: Generate the Controller

# Generate a UsersController with standard RESTful actions.

# $ rails generate controller Users index show new create edit update destroy

# Step 2: Follow RESTful Conventions

# Define RESTful actions in the controller.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

# Step 3: Extract Business Logic to Models or Services

# Move complex business logic from the controller to the model or a service object.

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  def self.recent
    order(created_at: :desc)
  end
end

# app/services/user_creation_service.rb
class UserCreationService
  def initialize(user_params)
    @user_params = user_params
  end

  def create_user
    user = User.new(@user_params)
    if user.save
      # Additional logic, e.g., sending a welcome email
      UserMailer.welcome_email(user).deliver_later
    end
    user
  end
end

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = UserCreationService.new(user_params).create_user
    if @user.persisted?
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end
end

# Step 4: Use Concerns for Shared Code

# Extract shared code into concerns.

# app/controllers/concerns/set_user.rb
module SetUser
  extend ActiveSupport::Concern

  included do
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  include SetUser

  # Rest of the controller code
end

# Summary

# - Follow RESTful conventions to keep your controllers organized and predictable.
# - Use strong parameters to securely handle form data.
# - Extract business logic to models or service objects to keep controllers thin.
# - Use concerns to share code between controllers.
# - Use callbacks wisely to manage common tasks.
# - Paginate large collections to improve performance and user experience.