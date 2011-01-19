class UsersController < ApplicationController
  before_filter :authenticate_user!

  def protect_page
    current_user.protect_page = params[:value]
    current_user.save
    redirect_to '/'
  end

  def lock_page
    current_user.locked_page = params[:value]
    current_user.save
    redirect_to '/'
  end
end
