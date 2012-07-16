module HomeHelper
  
  include UsersHelper
  
  def index
    if get_user.nil?
      redirect_to checkins_url
    end
  end
end
