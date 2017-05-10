FactoryGirl.define do
  factory :game do
    date "2017-05-10 15:10:52"
    winner :factory => :user
    loser :factory => :user
    winner_score 21
    loser_score 19
  end
end
