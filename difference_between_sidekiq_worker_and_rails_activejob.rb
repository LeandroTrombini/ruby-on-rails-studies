# Sidekiq Worker vs Rails ActiveJob

# Both Sidekiq Worker and Rails ActiveJob are used to handle background jobs in Rails applications.
# However, they have different purposes and use cases.

# Sidekiq Worker

# Sidekiq is a background job processing library that uses threads to handle many jobs at the same time in the same process.
# It is known for its performance and efficiency.

# Example

# Let's create an example with a Sidekiq worker to send a welcome email.

# Step 1: Add Sidekiq to Your Gemfile

# Gemfile
gem 'sidekiq'

# Run `bundle install` to install the gem.

# Step 2: Create a Worker

# Create a worker class that includes the Sidekiq::Worker module and defines a perform method.

# app/workers/welcome_email_worker.rb
class WelcomeEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.welcome_email(user).deliver_now
  end
end

# Step 3: Enqueue Jobs

# Enqueue jobs from your Rails application.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      WelcomeEmailWorker.perform_async(@user.id)
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

# Rails ActiveJob

# Rails ActiveJob is a framework for declaring jobs and making them run on a variety of queueing backends.
# It provides a single interface for different background job processors, including Sidekiq, Resque, Delayed Job, and others.

# Example

# Let's create an example with Rails ActiveJob to send a welcome email.

# Step 1: Create a Job

# Create a job class that inherits from ApplicationJob and defines a perform method.

# app/jobs/welcome_email_job.rb
class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.welcome_email(user).deliver_now
  end
end

# Step 2: Enqueue Jobs

# Enqueue jobs from your Rails application.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      WelcomeEmailJob.perform_later(@user)
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

# Summary

# - Sidekiq Worker: A background job processing library that uses threads to handle many jobs at the same time in the same process.
# - Rails ActiveJob: A framework for declaring jobs and making them run on a variety of queueing backends.
# - Sidekiq Worker is known for its performance and efficiency.
# - Rails ActiveJob provides a single interface for different background job processors.
# - Use Sidekiq Worker for high-performance, thread-based job processing.
# - Use Rails ActiveJob for flexibility and compatibility with multiple queueing backends.