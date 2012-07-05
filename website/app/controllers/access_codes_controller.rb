class AccessCodesController < ApplicationController
  
  def index
    foursquare = Foursquare::Base.new(
    "YTRDZFMWBREGWX4MUUAKUPFDZXU3TUVIWZ3HQY3UGITW1K3Y", 
    "AKBXY1M3PKL05TR0BHO1BE34W0U5OCWU54OOZZGU5503TMK0")
    @fsq_link = foursquare.authorize_url("http://localhost:3000/access_codes/new")
  end
  
  def new
    current_user.access_code = AccessCode.new(:code => params[:code])
    redirect_to root_url
  end
  
  def show
    
  end
  
end
