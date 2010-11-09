class PicturesController < ApplicationController
  before_filter :authenticate_user!,      :except => [:show, :index, :tags]
  before_filter :find_picture_by_id,      :only   => [:show, :edit, :update, :destroy]
  before_filter :authenticate_ownership!, :only   => [:edit, :update, :destroy]
 
  def index
    #if params[:user_id]
    #  @pictures = Picture.user(params[:user_id]).public.ordered.paginate(params[:page])
    #end

    @pictures ||= #Picture.includes(:tags, :user).public.ordered.paginate(params[:page])
  end

  def show
    if @picture.private && !owner?
      render :layout  => false, 
             :file    => "#{Rails.root}/public/404.html",
             :status  => 404 and return
    end
  end
  
  def tags
    if params[:tag]
      @pictures = Picture.joins(:tags).where(
        :tags => {:name => params[:tag]})
        .paginate(params[:page])
        .includes(:tags, :user)

    end

    @pictures ||=[]

    render :index
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
