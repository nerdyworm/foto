class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def user_profile
    @user = current_user
    
    render :action => "show" 
  end
  
  def show
    @user = User.find_by_username params[:username]
  end
 
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.bio = params[:user][:bio]

    if @user.save
      redirect_to(:user_profile, :notice => 'Profile was successfully updated.') 
    else
      render :action => "edit" 
    end
  end
end
