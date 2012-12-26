class HomeController < ApplicationController
  def index
    authorize! :index, @user, :message => 'Not logged in.'
  end
end
