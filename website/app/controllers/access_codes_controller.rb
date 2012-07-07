class AccessCodesController < ApplicationController
  
  CallbackUrl = "http://joelf.me/access_codes/new".freeze
  OAuthID = "YTRDZFMWBREGWX4MUUAKUPFDZXU3TUVIWZ3HQY3UGITW1K3Y".freeze
  OAuthSecret = "AKBXY1M3PKL05TR0BHO1BE34W0U5OCWU54OOZZGU5503TMK0".freeze
  def index
    foursquare = Foursquare::Base.new(OAuthID,OAuthSecret)
    @fsq_link = foursquare.authorize_url(CallbackUrl)
  end
  
  def new
    foursquare = Foursquare::Base.new(OAuthID,OAuthSecret)
    access_token = foursquare.access_token(params[:code], CallbackUrl)
    current_user.access_code = AccessCode.new(:code => access_token)
    redirect_to root_url
  end
  
  def show
    
  end
  
end
