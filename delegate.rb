# Delegates in Rails

# Delegates in Rails are a way to delegate method calls from one object to another associated object.
# This helps to keep your code clean and maintainable by reducing the need to write boilerplate code to pass method calls through multiple layers of objects.

# Using delegate

# The delegate method is used to delegate method calls to an associated object.
# It is defined in the model and specifies which methods should be delegated and to which associated object.

# Example

# Let's create an example with Author and Book models where a book can delegate some methods to its author.

# Step 1: Generate Models

# $ rails generate model Author name:string bio:text
# $ rails generate model Book title:string author:references
# $ rails db:migrate

# Step 2: Define Associations and Delegates

# app/models/author.rb
class Author < ApplicationRecord
  has_many :books
end

# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :author

  delegate :name, :bio, to: :author
end

# Example Usage in Rails Console

# Creating an author and a book
author = Author.create(name: 'John Doe', bio: 'An experienced author.')
book = Book.create(title: 'Rails for Beginners', author: author)

# Accessing delegated methods
puts book.name  # Output: John Doe
puts book.bio   # Output: An experienced author.

# Summary

# - Delegates in Rails are used to delegate method calls from one object to another associated object.
# - Use the delegate method in the model to specify which methods should be delegated and to which associated object.
# - Delegates help to keep your code clean and maintainable by reducing boilerplate code.