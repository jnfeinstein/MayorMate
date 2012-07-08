module UsersHelper
  
  def set_user(this_user)
    session[:user] = this_user
  end
  
  def get_user
    return session[:user]
  end
  
end
