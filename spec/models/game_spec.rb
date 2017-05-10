require 'rails_helper'

RSpec.describe Game, type: :model do
  it "has a valid factory" do
    expect(build(:game)).to be_valid
  end

  it { should validate_presence_of(:date) }
  it 'validates_timeliness of date' do
    expect(build(:game, date: 'pony')).to be_invalid
  end

  it { should validate_presence_of(:winner) }
  it { should validate_presence_of(:loser) }

  it { should validate_presence_of(:winner_score) }
  it { should validate_numericality_of(:winner_score)
        .only_integer
        .is_greater_than_or_equal_to(2)
        .is_less_than_or_equal_to(21)
     }

  it { should validate_presence_of(:loser_score) }
  it { should validate_numericality_of(:loser_score)
        .only_integer
        .is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(19)
     }

  it 'should validate winner is declared by a two point lead' do
    expect(build(:game, winner_score: 19, loser_score: 19)).to be_invalid
  end

  it 'should declare a winner' do
    current_user = create(:user)
    User.current = current_user
    opponent = create(:user)

    game = Game.new()
    game.date = '2017-05-17'
    game.opponent_id = opponent.id
    game.opponent_score = 21
    game.current_user_score = 19
    expect(game.valid?).to be true
  end

  it 'should know if the current user won' do
    current_user = create(:user)
    User.current = current_user
    game = build(:game, winner: current_user)
    expect(game.current_user_won?).to be true
  end

  it 'should know the opponent based on the current user' do
    current_user = create(:user)
    User.current = current_user
    opponent = create(:user)
    game = build(:game, winner: current_user, loser: opponent)
    expect(game.opponent).to be opponent
  end

  it 'should know the opponent score' do
    current_user = create(:user)
    User.current = current_user
    opponent = create(:user)
    game = build(:game, winner: current_user, loser: opponent)
    expect(game.opponent_score).to be 19
  end

  it 'should know the current user score' do
    current_user = create(:user)
    User.current = current_user
    opponent = create(:user)
    game = build(:game, winner: current_user, loser: opponent)
    expect(game.current_user_score).to be 21
  end
end
