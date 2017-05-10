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
end
