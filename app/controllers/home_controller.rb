class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @material = Material.next_for(current_user) if user_signed_in?
  end
end
