# Transactional Callbacks in ActiveRecord

# Transactional callbacks in ActiveRecord are callbacks that are executed within the context of a database transaction.
# This means that if the transaction is rolled back, the changes made by the callback will also be rolled back.
# This ensures data integrity and consistency.

# Example

# Let's create an example where we have a Payment model.
# We want to ensure that when a payment is created, a corresponding Transaction record is also created.
# If either the payment or the transaction fails, both should be rolled back.

# Step 1: Generate the Models
# $ rails generate model Payment amount:decimal
# $ rails generate model Transaction payment_id:integer status:string

# Step 2: Define the Models with Transactional Callbacks

# app/models/payment.rb
class Payment < ApplicationRecord
  has_one :transaction

  after_create :create_transaction

  private

  def create_transaction
    Transaction.create!(payment: self, status: 'pending')
  end
end

# app/models/transaction.rb
class Transaction < ApplicationRecord
  belongs_to :payment
end

# Example Usage in Rails Console

# Creating a payment and its transaction
payment = Payment.create(amount: 100.0)
puts payment.transaction.status  # Output: pending

# If the transaction creation fails, the payment creation will also be rolled back
begin
  Payment.transaction do
    payment = Payment.create!(amount: 100.0)
    raise ActiveRecord::Rollback if payment.transaction.nil?
  end
rescue ActiveRecord::Rollback
  puts "Transaction rolled back"
end

# Summary

# - Transactional Callbacks: Callbacks executed within the context of a database transaction.
# - Ensures data integrity and consistency by rolling back changes if the transaction fails.
# - Use after_create, after_save, and other lifecycle callbacks to add behavior to your models within a transaction.