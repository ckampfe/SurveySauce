class User < ActiveRecord::Base
  has_many :completes
  has_many :surveys
  has_many :responses
  # Remember to create a migration!
end
