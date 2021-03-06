class PicturesController < ApplicationController
  before_filter :authenticate_user!,      :except => [:show, :index, :tags]
  before_filter :find_picture_by_id,      :only   => [:show, :edit, :update, :destroy]
  before_filter :authenticate_ownership!, :only   => [:edit, :update, :destroy]

  respond_to :html, :js

  def index
    if params[:user_id]
      @pictures = Picture.find_by_user_id(params[:user_id])
    else
      @pictures = Picture
    end

    @pictures = @pictures.public.ordered.by_page(params[:page])

    respond_with(@pictures)
  end

  def show
    if @picture.private && !owner?
      render :layout  => false, 
             :file    => "#{Rails.root}/public/404.html",
             :status  => 404 and return
    end
  end
  
  def tags
    @pictures = []
    if params[:tag]
      @pictures = Picture.public.ordered.where(:tags.in => [params[:tag]])
    end

    render :index
  end

  def upvote 
    @picture = Picture.find(params[:picture_id])

    Picture.upvote(params[:picture_id], current_user.id)
    render :show
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
