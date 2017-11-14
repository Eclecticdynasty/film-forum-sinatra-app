class User < ActiveRecord::Base
  has_secure_password
  has_many :movies
  has_many :updates
  has_many :genres, through: :movies
end
