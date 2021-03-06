module UsersHelper
  
  @@CallbackUrl = "http://mayormate.herokuapp.com/users/login".freeze
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
    begin
      if session[:user].nil?
        return nil
      else
        return User.find(session[:user])
      end
    rescue
      reset_session
    end
  end
  
  def get_oath_foursquare
    return Foursquare::Base.new(@@OAuthID,@@OAuthSecret)
  end
  
  def get_authorize_url
    return get_oath_foursquare.authorize_url(@@CallbackUrl)
  end
  
  def get_access_token(code)
    return get_oath_foursquare.access_token(code, @@CallbackUrl)
  end
  
end
