class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      current_user.game_reset!
      @material = Material.next_for(current_user)
      @games = current_user.games.completed.order(:created_at)
    end
  end
end
