class LeaderboardController < ApplicationController
  def index
    @rankings = Ranking.all
  end
end

