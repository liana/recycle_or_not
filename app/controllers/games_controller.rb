class GamesController < ApplicationController
  load_resource
  authorize_resource :only => :index

  def index
    @games = Game.completed.order(:final_score).limit(10).all
  end
end
