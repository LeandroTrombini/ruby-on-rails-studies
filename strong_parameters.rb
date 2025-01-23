# Strong Parameters in Rails

# Strong Parameters is a feature in Rails that helps prevent mass assignment vulnerabilities by requiring and permitting specific parameters for your models.
# It ensures that only the allowed parameters are used to create or update a model, providing a layer of security.

# Example

# Let's create an example with a User model and demonstrate how to use strong parameters in a controller.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string age:integer admin:boolean
# $ rails db:migrate

# Step 2: Define the Controller

# Define a controller with actions to create and update users, using strong parameters to permit only the allowed attributes.

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

  # Strong Parameters
  def user_params
    params.require(:user).permit(:name, :email, :age)
  end
end

# Example Usage in Rails Console

# Creating a user
user = User.create(name: 'John Doe', email: 'john.doe@example.com', age: 30, admin: true)
# Only the permitted parameters (name, email, age) will be used, and admin will be ignored.

# Updating a user
user.update(name: 'Jane Doe', email: 'jane.doe@example.com', age: 25, admin: false)
# Only the permitted parameters (name, email, age) will be used, and admin will be ignored.

# Summary

# - Strong Parameters help prevent mass assignment vulnerabilities by requiring and permitting specific parameters for your models.
# - Use params.require(:model).permit(:attribute1, :attribute2, ...) to specify the allowed parameters.
# - Strong Parameters provide a layer of security by ensuring that only the permitted parameters are used to create or update a model.