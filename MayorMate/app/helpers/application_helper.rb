module ApplicationHelper
  def current_user
    return User.current_user
  end
  
  def current_user=(this_user)
    User.current_user = this_user
  end
end
