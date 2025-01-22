# Rake Tasks in Rails

# Rake is a Ruby task management library that allows you to define and run tasks from the command line.
# In Rails, Rake tasks are used for various purposes, such as database migrations, running tests, and performing maintenance tasks.

# Defining Custom Rake Tasks

# You can define custom Rake tasks in the lib/tasks directory of your Rails application.
# Each Rake task is defined in a .rake file.

# Example

# Let's create an example where we define a custom Rake task to send a welcome email to all users.

# Step 1: Create a Rake Task File

# Create a new file in the lib/tasks directory.

# $ mkdir -p lib/tasks
# $ touch lib/tasks/welcome_email.rake

# Step 2: Define the Rake Task

# Define the Rake task in the welcome_email.rake file.

# lib/tasks/welcome_email.rake
namespace :user do
  desc "Send welcome email to all users"
  task send_welcome_email: :environment do
    User.find_each do |user|
      UserMailer.welcome_email(user).deliver_now
      puts "Sent welcome email to #{user.email}"
    end
  end
end

# Running the Rake Task

# You can run the Rake task from the command line using the rake command.

# $ rake user:send_welcome_email

# Summary

# - Rake is a Ruby task management library that allows you to define and run tasks from the command line.
# - In Rails, Rake tasks are used for various purposes, such as database migrations, running tests, and performing maintenance tasks.
# - Define custom Rake tasks in the lib/tasks directory.
# - Use the namespace method to group related tasks.
# - Use the desc method to provide a description for the task.
# - Use the task method to define the task and its dependencies.
# - Run the Rake task from the command line using the rake command.