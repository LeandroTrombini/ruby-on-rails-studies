# Types of Associations in Rails

# Rails provides several types of associations to define relationships between models.
# These associations help to manage the relationships and interactions between different models in a Rails application.

# 1. belongs_to

# The belongs_to association sets up a one-to-one connection with another model.
# This association indicates that each instance of the declaring model belongs to one instance of the other model.

# Example
# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :author
end

# app/models/author.rb
class Author < ApplicationRecord
  has_many :posts
end

# 2. has_one

# The has_one association sets up a one-to-one connection with another model.
# This association indicates that each instance of the declaring model has one instance of the other model.

# Example
# app/models/user.rb
class User < ApplicationRecord
  has_one :profile
end

# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user
end

# 3. has_many

# The has_many association sets up a one-to-many connection with another model.
# This association indicates that each instance of the declaring model can be associated with multiple instances of the other model.

# Example
# app/models/author.rb
class Author < ApplicationRecord
  has_many :posts
end

# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :author
end

# 4. has_many :through

# The has_many :through association sets up a many-to-many connection with another model through a third model.
# This is useful when you need to work with the relationship model as its own entity.

# Example
# app/models/doctor.rb
class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

# app/models/patient.rb
class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
end

# app/models/appointment.rb
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
end

# 5. has_one :through

# The has_one :through association sets up a one-to-one connection with another model through a third model.
# This is useful when you want to set up a one-to-one connection that goes through another model.

# Example
# app/models/supplier.rb
class Supplier < ApplicationRecord
  has_one :account
  has_one :account_history, through: :account
end

# app/models/account.rb
class Account < ApplicationRecord
  belongs_to :supplier
  has_one :account_history
end

# app/models/account_history.rb
class AccountHistory < ApplicationRecord
  belongs_to :account
end

# 6. has_and_belongs_to_many

# The has_and_belongs_to_many association sets up a direct many-to-many connection with another model.
# This association uses a join table without a corresponding model.

# Example
# app/models/student.rb
class Student < ApplicationRecord
  has_and_belongs_to_many :courses
end

# app/models/course.rb
class Course < ApplicationRecord
  has_and_belongs_to_many :students
end

# Summary

# - belongs_to: One-to-one connection with another model.
# - has_one: One-to-one connection with another model.
# - has_many: One-to-many connection with another model.
# - has_many :through: Many-to-many connection with another model through a third model.
# - has_one :through: One-to-one connection with another model through a third model.
# - has_and_belongs_to_many: Direct many-to-many connection with another model using a join table.