# Action Cable in Rails

# Action Cable is a framework in Rails that integrates WebSockets with the rest of your Rails application.
# It allows you to create real-time features like chat applications, notifications, live updates, and more.
# Action Cable seamlessly integrates with Rails, making it easy to add real-time functionality to your application.

# Key Features

# 1. Real-time Communication: Enables real-time communication between the server and the client using WebSockets.
# 2. Channels: Provides a way to group related WebSocket connections.
# 3. Broadcasting: Allows you to broadcast messages to multiple clients subscribed to a channel.
# 4. Integration: Integrates with Rails models, controllers, and views.

# Example

# Let's create an example where we use Action Cable to build a simple chat application.

# Step 1: Generate the Channel

# Generate a channel using the Rails generator:

# $ rails generate channel Chat

# This will create a channel file and a corresponding CoffeeScript file for the client-side code.

# Step 2: Define the Channel

# Define the channel in app/channels/chat_channel.rb.

# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast "chat_#{params[:room]}", message: data['message']
  end
end

# Step 3: Create the Client-Side Code

# Create the client-side code to connect to the channel and handle incoming messages.

# app/javascript/channels/chat_channel.js
import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ChatChannel", room: "public" }, {
  connected() {
    console.log("Connected to the chat channel.")
  },

  disconnected() {
    console.log("Disconnected from the chat channel.")
  },

  received(data) {
    const messages = document.getElementById('messages')
    messages.insertAdjacentHTML('beforeend', `<p>${data.message}</p>`)
  },

  speak(message) {
    this.perform('speak', { message: message })
  }
})

# app/javascript/packs/application.js
import "channels"

# Step 4: Create the View

# Create a view to display the chat messages and a form to send new messages.

# app/views/chat_rooms/show.html.erb
<h1>Chat Room</h1>
<div id="messages"></div>
<form id="new_message" action="#">
  <input type="text" id="message_content">
  <input type="submit" value="Send">
</form>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const chatChannel = consumer.subscriptions.create({ channel: "ChatChannel", room: "public" }, {
      received(data) {
        const messages = document.getElementById('messages')
        messages.insertAdjacentHTML('beforeend', `<p>${data.message}</p>`)
      }
    })

    document.getElementById('new_message').addEventListener('submit', (event) => {
      event.preventDefault()
      const messageContent = document.getElementById('message_content').value
      chatChannel.speak(messageContent)
      document.getElementById('message_content').value = ''
    })
  })
</script>

# Summary

# - Action Cable is a framework in Rails that integrates WebSockets with the rest of your Rails application.
# - It allows you to create real-time features like chat applications, notifications, live updates, and more.
# - Generate a channel using the Rails generator.
# - Define the channel in app/channels/channel_name_channel.rb.
# - Create the client-side code to connect to the channel and handle incoming messages.
# - Create a view to display the real-time data and handle user interactions.