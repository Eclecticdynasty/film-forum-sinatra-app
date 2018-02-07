class User < ActiveRecord::Base
  has_secure_password
  # has_many :user_movies
  has_many :movies 
  has_many :updates
  has_many :genres, through: :movies



  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug
    User.all.find {|user| user.slug == slug}
  end
end
