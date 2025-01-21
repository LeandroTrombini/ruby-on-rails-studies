# Webpacker vs Sprockets in Rails

# Rails provides two different tools for managing assets: Webpacker and Sprockets.
# Both serve the purpose of handling assets like JavaScript, CSS, and images, but they have different approaches and use cases.

# Sprockets

# Sprockets is the traditional asset pipeline in Rails. It compiles and serves assets like JavaScript, CSS, and images.
# It uses a manifest file to determine which assets to include and in what order.

# Example

# Configuration: Sprockets is configured by default in Rails applications.

# Manifest File: The manifest file is typically located at app/assets/config/manifest.js.

# app/assets/config/manifest.js
//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_directory ../javascripts .js

# Including Assets: You can include assets in your views using helpers like javascript_include_tag and stylesheet_link_tag.

# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>MyApp</title>
  <%= stylesheet_link_tag 'application', media: 'all' %>
  <%= javascript_include_tag 'application' %>
  <%= csrf_meta_tags %>
</head>
<body>
  <%= yield %>
</body>
</html>

# Webpacker

# Webpacker is a modern JavaScript toolchain that uses Webpack to manage assets.
# It is more powerful and flexible than Sprockets, especially for handling complex JavaScript applications and modern front-end frameworks like React, Vue, and Angular.

# Example

# Installation: Webpacker is included by default in Rails 6 and later. For earlier versions, you can add it to your Gemfile.

# Gemfile
gem 'webpacker'

# Configuration: Run the Webpacker installer to set up the necessary files.

# $ rails webpacker:install

# JavaScript Packs: Create JavaScript packs in the app/javascript/packs directory.

# app/javascript/packs/application.js
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

# Including Packs: Include the JavaScript packs in your views using the javascript_pack_tag helper.

# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>MyApp</title>
  <%= stylesheet_pack_tag 'application', media: 'all' %>
  <%= javascript_pack_tag 'application' %>
  <%= csrf_meta_tags %>
</head>
<body>
  <%= yield %>
</body>
</html>

# Summary

# - Sprockets: Traditional asset pipeline, compiles and serves assets, uses manifest file, includes assets with javascript_include_tag and stylesheet_link_tag.
# - Webpacker: Modern JavaScript toolchain, uses Webpack, handles complex JavaScript applications, includes assets with javascript_pack_tag and stylesheet_pack_tag.