class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.opponents
    self.where.not(id: self.current.id).order(:email)
  end
end
