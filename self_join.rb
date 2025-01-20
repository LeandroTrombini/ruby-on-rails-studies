# app/models/employee.rb
class Employee < ApplicationRecord
  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'
end

# Explanation of Associations

# - belongs_to :manager, class_name: 'Employee', optional: true: Defines that an Employee can have a manager, who is also an Employee.
# - has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id': Defines that an Employee can have many subordinates, who are also Employees.

# Explanation of Associations

# - belongs_to :manager, class_name: 'Employee', optional: true: Defines that an Employee can have a manager, who is also an Employee.
# - has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id': Defines that an Employee can have many subordinates, who are also Employees.

# Creating Example Data

# In the Rails console, you can create some records to test:

# Creating employees

manager = Employee.create(name: 'Manager')
employee1 = Employee.create(name: 'Employee 1', manager: manager)
employee2 = Employee.create(name: 'Employee 2', manager: manager)
employee3 = Employee.create(name: 'Employee 3', manager: employee1)

# Checking associations
puts "Manager: #{manager.name}"
manager.subordinates.each do |subordinate|
  puts "Subordinate: #{subordinate.name}"
end

puts "Employee 1's Manager: #{employee1.manager.name}"
puts "Employee 1's Subordinates: #{employee1.subordinates.map(&:name).join(', ')}"

# Expected Output

# Manager: Manager
# Subordinate: Employee 1
# Subordinate: Employee 2
# Employee 1's Manager: Manager
# Employee 1's Subordinates: Employee 3