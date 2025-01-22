# Partials in Rails

# Partials in Rails are a way to break down views into smaller, reusable components.
# They help keep your views DRY (Don't Repeat Yourself) and organized.

# Creating a Partial

# A partial is a view file whose name starts with an underscore (_). For example, _form.html.erb.

# Example

# Let's create an example with a User model and a partial to display user information.

# Step 1: Generate the Model

# $ rails generate model User name:string email:string
# $ rails db:migrate

# Step 2: Seed Data

# db/seeds.rb
User.create(name: 'John Doe', email: 'john.doe@example.com')
User.create(name: 'Jane Doe', email: 'jane.doe@example.com')

# Step 3: Create a Partial

# Create a partial to display user information.

# app/views/users/_user.html.erb

# <div class="user">
#   <h2><%= user.name %></h2>
#   <p>Email: <%= user.email %></p>
# </div>

# Rendering a Partial

# You can render a partial in a view using the render method.

# Example

# Render the _user.html.erb partial in the index.html.erb view.

# app/views/users/index.html.erb

# <h1>Users</h1>
# <% @users.each do |user| %>
#   <%= render partial: 'user', locals: { user: user } %>
# <% end %>

# Passing Local Variables to a Partial

# You can pass local variables to a partial using the locals option.

# Example

# Pass a local variable to the _user.html.erb partial.

# app/views/users/index.html.erb

# <h1>Users</h1>
# <% @users.each do |user| %>
#   <%= render partial: 'user', locals: { user: user } %>
# <% end %>

# Summary

# - Partials are a way to break down views into smaller, reusable components.
# - Create a partial by naming the view file with an underscore (_) prefix.
# - Render a partial using the render method.
# - Pass local variables to a partial using the locals option.