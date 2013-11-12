require "bcrypt"

class User < ActiveRecord::Base
  has_many :completes
  has_many :surveys
  has_many :responses

  # has_secure_password
  # Remember to create a migration!
  has_secure_password
  
end
