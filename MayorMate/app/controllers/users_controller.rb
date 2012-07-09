class UsersController < ApplicationController
  
  include UsersHelper

  def landing
    redirect_to get_authorize_url
  end
  
  def login
    access_token = get_access_token(params[:code])
    this_user = User.where(:access_token => access_token).first
    if this_user.nil?
      this_user = User.new(:access_token => access_token)
      this_user.save
    end
    set_user(this_user)
    redirect_to checkins_url
  end
  
  def logout
    set_user(nil)
    redirect_to root_url
  end
  
end
