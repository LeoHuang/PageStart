class HomeController < ApplicationController
  def index
    @user = current_user if user_signed_in?
    @user ||= User.find_by_email('i@histart.me')
    @floors = @user.floors.order('postion_at') if @user
    @floors ||= []
  end

end
