class ApplicationController < ActionController::Base
  protect_from_forgery


  def after_sign_in_path_for(user)
    user_profile_path
  end


  def admin?
    current_user && current_user.admin
  end

  def authenticate_admin!
    unless admin?
      redirect_to(root_url)
    end
  end
end
