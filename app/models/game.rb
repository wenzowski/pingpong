class Game < ActiveRecord::Base
  belongs_to :winner, :class_name => 'User'
  belongs_to :loser, :class_name => 'User'
  attr_accessor :opponent_id
  attr_accessor :opponent_score
  attr_accessor :current_user_score

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

  before_validation do
    if opponent_id && opponent_score && current_user_score
      if opponent_score > current_user_score
        self.winner = User.find(opponent_id)
        self.winner_score = opponent_score
        self.loser = User.current
        self.loser_score = current_user_score
      else
        self.winner = User.current
        self.winner_score = current_user_score
        self.loser = User.find(opponent_id)
        self.loser_score = opponent_score
      end
    end
  end

  def opponent
    return @opponent if @opponent
    return self.loser if self.current_user_won?
    return self.winner
  end

  def opponent_email
    self.opponent.email
  end

  def opponent_score
    return @opponent_score if @opponent_score
    return self.loser_score if self.current_user_won?
    return self.winner_score
  end

  def current_user_won?
    User.current == self.winner
  end

  def current_user_score
    return @current_user_score if @current_user_score
    return self.winner_score if self.current_user_won?
    return self.loser_score
  end
end
