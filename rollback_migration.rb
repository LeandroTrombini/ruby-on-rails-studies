# Rolling Back a Migration in Rails

# Rolling back a migration in Rails means undoing the changes made by a specific migration.
# This is useful when you need to revert the database schema to a previous state.

# How to Roll Back a Migration

# 1. Rolling Back the Last Migration:
# $ rails db:rollback

# 2. Rolling Back Multiple Migrations:
# $ rails db:rollback STEP=n
# Replace `n` with the number of migrations you want to roll back.

# 3. Rolling Back to a Specific Migration:
# $ rails db:migrate:down VERSION=xxxxxx
# Replace `xxxxxx` with the version number of the migration you want to roll back.

# Example

# Let's create a migration, apply it, and then roll it back.

# Step 1: Generate a Migration
# $ rails generate migration AddAgeToUsers age:integer

# Step 2: Apply the Migration
# $ rails db:migrate

# Step 3: Roll Back the Last Migration
# $ rails db:rollback

# Step 4: Roll Back to a Specific Migration

# Assume you have the following migrations:
# - 20231010123456_create_users.rb
# - 20231010123567_add_age_to_users.rb

# To roll back to the `create_users` migration:
# $ rails db:migrate:down VERSION=20231010123567

# Summary

# Rolling back a migration allows you to undo changes made to the database schema.
# Use `rails db:rollback` to roll back the last migration.
# Use `rails db:rollback STEP=n` to roll back multiple migrations.
# Use `rails db:migrate:down VERSION=xxxxxx` to roll back to a specific migration.