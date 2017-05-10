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

  def self.rankings
    # ran out of time
    # This should be a pg query which awards points based on the number of games where users.id = games.winner_id adjusted by count of games.loser_id = games.winner_id
  end
end
