class UsersController < ApplicationController
  
  include UsersHelper
  
  CallbackUrl = "http://joelf.me/users/login".freeze
  OAuthID = "YTRDZFMWBREGWX4MUUAKUPFDZXU3TUVIWZ3HQY3UGITW1K3Y".freeze
  OAuthSecret = "AKBXY1M3PKL05TR0BHO1BE34W0U5OCWU54OOZZGU5503TMK0".freeze
  def landing
    redirect_to get_authorize_url
  end
  
  def login
    foursquare = Foursquare::Base.new(OAuthID,OAuthSecret)
    access_token = foursquare.access_token(params[:code], CallbackUrl)
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
