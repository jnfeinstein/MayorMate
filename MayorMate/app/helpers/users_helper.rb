module UsersHelper
  
  @@CallbackUrl = "http://joelf.me/users/login".freeze
  @@OAuthID = "YTRDZFMWBREGWX4MUUAKUPFDZXU3TUVIWZ3HQY3UGITW1K3Y".freeze
  @@OAuthSecret = "AKBXY1M3PKL05TR0BHO1BE34W0U5OCWU54OOZZGU5503TMK0".freeze
  
  def set_user(this_user)
    if !this_user.nil?
      session[:user] = this_user.id
    else
      session[:user] = nil
    end
  end
  
  def get_user
    if session[:user].nil?
      return nil
    else
      return User.find(session[:user])
    end
  end
  
  def get_oath_foursquare
    return Foursquare::Base.new(@@OAuthID,@@OAuthSecret)
  end
  
  def get_authorize_url
    return get_oath_foursquare.authorize_url(@@CallbackUrl)
  end
  
end
