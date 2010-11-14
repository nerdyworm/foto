class FeedbacksController < ApplicationController
  before_filter :authenticate_user!

  def upvote
    Feedback.upvote(params[:id], current_user.id)
  end

  def downvote
    Feedback.downvote(params[:id], current_user.id)
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      @feedback.email    = current_user.email
      @feedback.username = current_user.username
      @picture.feedbacks << @feedback
      @picture.save 
      
      puts @picture.feedbacks.first.username

      redirect_to(@picture, :notice => 'Feedback was added!')
    else
      redirect_to(@picture, :alert => 'Adding feedback failed!')
    end
  end


end
