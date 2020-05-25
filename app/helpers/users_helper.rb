module UsersHelper
  def all_other_users
    return [] if session[:user_id].nil?
    users = User.all
    filtered_users = []
    users.each do |u|
      filtered_users << u if u.id != session[:user_id]
    end
    filtered_users
  end

  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end
end
