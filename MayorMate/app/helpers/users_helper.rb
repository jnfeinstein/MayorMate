module UsersHelper
  
  def set_user(this_user)
    session[:user] = this_user.id
  end
  
  def get_user
    return User.find(session[:user])
  end
  
end
