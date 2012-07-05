class HomeController < ApplicationController
  
  def index
    if current_user.access_code.nil?
      redirect_to access_codes_path
    end
  end 
end
