# Changing Table Name Convention in Rails

# By default, Rails uses naming conventions to map class names to table names.
# However, you can override these conventions using the self.table_name method in the model.

# Example

# Let's assume you have a model Author, but the corresponding table in the database is named writers.

# Step 1: Generate the model
# $ rails generate model Author name:string

# Step 2: Modify the migration to create the writers table
# db/migrate/xxxxxx_create_authors.rb
class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :writers do |t|
      t.string :name

      t.timestamps
    end
  end
end

# Step 3: Modify the model to use the writers table
# app/models/author.rb
class Author < ApplicationRecord
  self.table_name = 'writers'
end

# Step 4: Run the migration
# $ rails db:migrate

# Example Usage in Rails Console

# Creating an author
author = Author.create(name: 'John Doe')

# Querying an author
author = Author.find_by(name: 'John Doe')
puts author.name  # Output: John Doe

# Summary

# - self.table_name: Use this method in the model to specify a different table name.
# - Migration: Ensure the migration creates the table with the desired name.
# - Model: Define self.table_name in the model to map the class to the correct table.

# This allows you to use custom table names while still leveraging the benefits of ActiveRecord in Rails.