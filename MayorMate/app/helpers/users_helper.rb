module UsersHelper
  
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
end
