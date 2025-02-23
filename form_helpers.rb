# Form Helpers in Rails

# Rails provides a variety of form helpers to create forms and manage form data.
# These helpers generate HTML form elements and handle form submission, making it easier to work with forms in Rails applications.

# Common Form Helpers

# 1. form_with
# 2. form_for
# 3. form_tag

# 1. form_with

# Usage: form_with is the most recent and flexible form helper introduced in Rails 5.1. It can be used with both model-backed and non-model-backed forms.
# Features: Automatically determines whether to use remote forms (AJAX) based on the presence of a model object. It also supports custom form builders.
# Example:

# app/views/users/_form.html.erb
<%= form_with(model: @user, local: true) do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>

  <%= form.label :email %>
  <%= form.email_field :email %>

  <%= form.submit %>
<% end %>

# 2. form_for

# Usage: form_for is used to create forms for model-backed objects. It automatically sets the form's action and method based on the model's state (new or existing).
# Features: Provides a convenient way to create forms for Active Record objects, including nested attributes.
# Example:

# app/views/users/_form.html.erb
<%= form_for(@user) do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>

  <%= form.label :email %>
  <%= form.email_field :email %>

  <%= form.submit %>
<% end %>

# 3. form_tag

# Usage: form_tag is used to create forms that are not directly tied to a model. It provides more control over the form's action and method.
# Features: Useful for creating forms that submit to custom URLs or handle non-model data.
# Example:

# app/views/users/search.html.erb
<%= form_tag(search_users_path, method: :get) do %>
  <%= label_tag :query, "Search for:" %>
  <%= text_field_tag :query %>

  <%= submit_tag "Search" %>
<% end %>

# Summary

# - form_with: Flexible form helper for both model-backed and non-model-backed forms. Supports remote forms (AJAX) and custom form builders.
# - form_for: Used for model-backed forms. Automatically sets the form's action and method based on the model's state.
# - form_tag: Used for non-model-backed forms. Provides more control over the form's action and method.