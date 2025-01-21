# Single Table Inheritance (STI) in Rails

# Single Table Inheritance (STI) is a feature in Rails that allows multiple models to be stored in a single database table.
# This is useful when you have different types of objects that share a lot of common attributes but also have some unique attributes.

# Example

# Let's create an example with Vehicle, Car, and Motorcycle models where Car and Motorcycle inherit from Vehicle.

# Step 1: Generate the Base Model

# $ rails generate model Vehicle type:string name:string speed:integer

# Step 2: Define the Models

# app/models/vehicle.rb
class Vehicle < ApplicationRecord
  self.inheritance_column = :type
end

# app/models/car.rb
class Car < Vehicle
end

# app/models/motorcycle.rb
class Motorcycle < Vehicle
end

# Step 3: Migrate the Database

# $ rails db:migrate

# Example Usage in Rails Console

# Creating vehicles
car = Car.create(name: 'Toyota', speed: 120)
motorcycle = Motorcycle.create(name: 'Harley', speed: 100)

# Querying vehicles
vehicles = Vehicle.all
vehicles.each do |vehicle|
  puts "#{vehicle.type}: #{vehicle.name} - #{vehicle.speed} km/h"
end
# Output:
# Car: Toyota - 120 km/h
# Motorcycle: Harley - 100 km/h

# Advantages of STI

# Simplicity: All records are stored in a single table, making it easier to manage and query.
# DRY (Don't Repeat Yourself): Shared attributes and methods are defined in the base class, reducing code duplication.
# Polymorphism: Allows for polymorphic behavior, where you can treat different types of objects as instances of the base class.

# Disadvantages of STI

# Table Bloat: As the number of subclasses grows, the table can become large and sparse, with many unused columns for each record.
# Complexity: Handling unique attributes for each subclass can become complex and may require additional logic.
# Performance: Queries can become slower as the table grows, especially if there are many unused columns.

# Summary

# - Single Table Inheritance (STI) allows multiple models to be stored in a single database table.
# - Define the base model with a type column and inherit other models from it.
# - Use self.inheritance_column = :type to specify the column used for STI.