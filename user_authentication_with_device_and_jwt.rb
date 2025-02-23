# Implementing User Authentication Using Devise and JWT in Rails

# To implement user authentication using Devise and JWT (JSON Web Tokens) in a Rails application, you can follow these steps:

# Step 1: Set Up Devise

# 1.1 Add Devise to Your Gemfile

# Gemfile
gem 'devise'

# Run `bundle install` to install the gem.

# 1.2 Install Devise

# Run the Devise installation generator:

# $ rails generate devise:install

# Follow the instructions provided by the generator to complete the setup.

# 1.3 Generate the User Model

# Generate the User model with Devise:

# $ rails generate devise User
# $ rails db:migrate

# Step 2: Configure JWT

# 2.1 Add JWT Gem to Your Gemfile

# Gemfile
gem 'jwt'

# Run `bundle install` to install the gem.

# 2.2 Create a JWT Service

# Create a service to handle JWT encoding and decoding.

# app/services/json_web_token.rb
class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end
end

# 2.3 Create a Sessions Controller

# Create a custom SessionsController to handle user login and generate JWT tokens.

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end

# 2.4 Add Routes for Sessions

# Add routes for the SessionsController.

# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  post 'login', to: 'sessions#create'
end

# 2.5 Authenticate Requests Using JWT

# Create a method to authenticate requests using JWT tokens.

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end

# Summary

# - Set up Devise for user authentication.
# - Configure JWT for token-based authentication.
# - Create a JWT service to handle encoding and decoding of tokens.
# - Create a custom SessionsController to handle user login and generate JWT tokens.
# - Add routes for the SessionsController.
# - Authenticate requests using JWT tokens in the ApplicationController.