class PicturesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_picture_by_id, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_ownership!, :only => [:edit, :update, :destroy]
 
  def index
    @pictures = Picture.all
  end

  def show
    if @picture.private && !owner?
      render :layout  => false, 
             :file    => "#{Rails.root}/public/404.html",
             :status  => 404 and return
    end
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(params[:picture])
    @picture.user = current_user

   if @picture.save
     redirect_to(@picture, :notice => 'Picture was successfully created.')
   else
     render :action => "new" 
   end
  end

  def update

    if @picture.update_attributes(params[:picture])
      redirect_to(@picture, :notice => 'Picture was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @picture.destroy

    redirect_to(pictures_url, :notice => 'Picture was successfully deleted.')
  end
  
  private
  
  def find_picture_by_id
    @picture = Picture.find(params[:id])
  end
  
  def authenticate_ownership!
    unless owner?
      redirect_to(user_profile_path, :alert => "You can not do such things!")
    end
  end
  
  def owner?
    (@picture && current_user && @picture.user == current_user)
  end
end
