# Sidekiq in Rails

# Sidekiq is a background job processing library for Ruby that uses threads to handle many jobs at the same time in the same process.
# It is commonly used in Rails applications to perform tasks asynchronously, such as sending emails, processing files, or making HTTP requests.

# How Sidekiq Works

# Sidekiq uses Redis as a job management store. Jobs are enqueued in Redis and processed by Sidekiq workers.
# Each worker is a Ruby class that includes the Sidekiq::Worker module and defines a perform method.

# Setting Up Sidekiq

# Step 1: Add Sidekiq to Your Gemfile

# Gemfile
gem 'sidekiq'

# Run `bundle install` to install the gem.

# Step 2: Configure Sidekiq

# Create a Sidekiq configuration file.

# config/sidekiq.yml
:concurrency: 5
:queues:
  - default
  - mailers

# Step 3: Create a Worker

# Create a worker class that includes the Sidekiq::Worker module and defines a perform method.

# app/workers/hard_worker.rb
class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts "Doing hard work #{count} times for #{name}"
  end
end

# Step 4: Enqueue Jobs

# Enqueue jobs from your Rails application.

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      HardWorker.perform_async(@user.name, 5)
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

# Running Sidekiq

# Development Environment

# In the development environment, you can start Sidekiq using the following command:

# $ bundle exec sidekiq -C config/sidekiq.yml

# This will start Sidekiq with the configuration specified in config/sidekiq.yml.

# Production Environment

# In the production environment, you typically use a process manager like systemd, upstart, or foreman to manage Sidekiq processes. Here is an example using systemd:

# Create a systemd service file for Sidekiq.

# /etc/systemd/system/sidekiq.service

# [Unit]
# Description=Sidekiq Background Worker
# After=syslog.target network.target

# [Service]
# Type=simple
# WorkingDirectory=/path/to/your/app
# ExecStart=/usr/local/bin/bundle exec sidekiq -e production -C config/sidekiq.yml
# User=deploy
# Group=deploy
# UMask=0002
# RestartSec=1
# Restart=on-failure

# [Install]
# WantedBy=multi-user.target

# Enable and start the Sidekiq service.

# $ sudo systemctl enable sidekiq
# $ sudo systemctl start sidekiq

# Summary

# - Sidekiq is a background job processing library for Ruby that uses threads to handle many jobs at the same time in the same process.
# - Sidekiq uses Redis as a job management store.
# - Create a worker class that includes the Sidekiq::Worker module and defines a perform method.
# - Enqueue jobs from your Rails application using the perform_async method.
# - Start Sidekiq in the development environment using the bundle exec sidekiq command.
# - Use a process manager like systemd to manage Sidekiq processes in the production environment.