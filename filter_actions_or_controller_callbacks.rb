# Filter Actions or Controller Callbacks in Rails

# Filter actions, also known as controller callbacks, are methods that are called at certain points in the lifecycle of a controller action.
# They allow you to run shared code before, after, or around controller actions, helping to keep your code DRY (Don't Repeat Yourself).

# Types of Callbacks

# 1. before_action: Runs a method before the controller action.
# 2. after_action: Runs a method after the controller action.
# 3. around_action: Runs a method both before and after the controller action.

# Example

# Let's create an example with a UsersController and demonstrate how to use before_action, after_action, and around_action callbacks.

# Step 1: Generate the Controller

# $ rails generate controller Users index show new create edit update destroy

# Step 2: Define Callbacks in the Controller

# Define callbacks in the UsersController to run shared code before, after, and around actions.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  after_action :log_action, only: [:create, :update, :destroy]
  around_action :wrap_in_transaction, only: [:create, :update, :destroy]

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

  def authenticate_user
    # Simulate authentication logic
    puts "Authenticating user..."
  end

  def log_action
    # Simulate logging logic
    puts "Action logged: #{action_name}"
  end

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      puts "Starting transaction..."
      yield
      puts "Ending transaction..."
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :age)
  end
end

# Example Usage in Rails Console

# Creating a user
user = User.create(name: 'John Doe', email: 'john.doe@example.com', age: 30)
# Output:
# Authenticating user...
# Starting transaction...
# Ending transaction...
# Action logged: create

# Updating a user
user.update(name: 'Jane Doe')
# Output:
# Authenticating user...
# Starting transaction...
# Ending transaction...
# Action logged: update

# Summary

# - Filter actions, or controller callbacks, are methods that are called at certain points in the lifecycle of a controller action.
# - Use before_action to run a method before the controller action.
# - Use after_action to run a method after the controller action.
# - Use around_action to run a method both before and after the controller action.
# - Callbacks help keep your code DRY by running shared code across multiple actions.