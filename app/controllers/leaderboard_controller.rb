class LeaderboardController < ApplicationController
  def index
    @users = User.rankings
  end
end

