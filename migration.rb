# Migrations in Rails

# Migrations in Rails are a way to manage changes to your database schema over time.
# They allow you to create, modify, and drop database tables and columns in a structured and version-controlled manner.

# Creating a Migration

# You can generate a migration using the Rails generator. For example, to create a migration to add a users table:

# $ rails generate migration CreateUsers

# This will create a migration file in the db/migrate directory.

# Example Migration

# Let's create an example migration to add a users table with name and email columns.

# Step 1: Generate the Migration

# $ rails generate migration CreateUsers name:string email:string

# Step 2: Define the Migration

# db/migrate/20231010123456_create_users.rb
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end

# Step 3: Run the Migration

# $ rails db:migrate

# Example Usage in Rails Console

# Creating a user
user = User.create(name: 'John Doe', email: 'john.doe@example.com')

# Querying users
users = User.all
users.each do |user|
  puts "User: #{user.name}, Email: #{user.email}"
end

# Summary

# - Migrations manage changes to your database schema over time.
# - Generate migrations using the Rails generator.
# - Define the changes in the migration file.
# - Run the migration using rails db:migrate.