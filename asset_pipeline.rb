# Asset Pipeline in Rails

# The Asset Pipeline in Rails is a framework that provides a powerful way to manage and serve static assets such as JavaScript, CSS, and images.
# It allows you to organize your assets, preprocess them, and serve them efficiently in production.

# Key Features

# 1. Concatenation: Combines multiple files into a single file to reduce the number of HTTP requests.
# 2. Minification: Reduces the size of files by removing unnecessary characters.
# 3. Preprocessing: Allows you to use languages like Sass, CoffeeScript, and ERB in your assets.
# 4. Fingerprinting: Adds a unique fingerprint to asset filenames to ensure that browsers always load the latest version.

# Example

# Let's create an example to demonstrate how to use the Asset Pipeline in a Rails application.

# Step 1: Organize Assets

# Place your assets in the appropriate directories under app/assets, lib/assets, or vendor/assets.

# app/assets/
#   javascripts/
#     application.js
#     custom.js
#   stylesheets/
#     application.css
#     custom.css
#   images/
#     logo.png

# Step 2: Include Assets in the Manifest Files

# Include your assets in the manifest files (application.js and application.css).

# app/assets/javascripts/application.js
//= require rails-ujs
//= require turbolinks
//= require_tree .

# app/assets/javascripts/custom.js
console.log('Custom JavaScript loaded');

# app/assets/stylesheets/application.css
/*
 *= require_tree .
 *= require_self
 */

# app/assets/stylesheets/custom.css
body {
  background-color: #f0f0f0;
}

# Step 3: Use Asset Helpers in Views

# Use asset helpers in your views to include the assets.

# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>Asset Pipeline Example</title>
  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>

  <%= stylesheet_link_tag 'application', media: 'all' %>
  <%= javascript_include_tag 'application' %>
</head>
<body>
  <%= yield %>
</body>
</html>

# Summary

# - The Asset Pipeline in Rails is a framework that provides a powerful way to manage and serve static assets.
# - Organize your assets in the app/assets, lib/assets, or vendor/assets directories.
# - Include your assets in the manifest files (application.js and application.css).
# - Use asset helpers in your views to include the assets.
# - The Asset Pipeline provides features like concatenation, minification, preprocessing, and fingerprinting to optimize asset management and delivery.