class Game < ActiveRecord::Base
  attr_accessor :date
  belongs_to :winner, :class_name => 'User'
  belongs_to :loser, :class_name => 'User'
  attr_accessor :winner_score
  attr_accessor :loser_score

  validates :date, presence: true, timeliness: {:type => :date}
  validates :winner, presence: true
  validates :loser, presence: true
  validates :winner_score,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 2,
      less_than_or_equal_to: 21
    }
  validates :loser_score,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 19
    }

  validate :two_point_lead
  def two_point_lead
    if winner_score.present? && loser_score.present? && (winner_score - loser_score) < 2
      errors.add(:loser_score, "ping pong rules require a winner to be declared by a two point margin")
    end
  end
end
