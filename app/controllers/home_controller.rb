class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :reset_game

  def index
    if user_signed_in?
      @material = Material.next_for(current_user)
      @games = current_user.games.completed.order(:created_at)
    end
  end

  private

  def reset_game
    if user_signed_in? && current_user.game_completed?
      current_user.game_reset!
    end
  end
end
