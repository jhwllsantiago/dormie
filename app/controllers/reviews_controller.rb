class ReviewsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_occupant!
  before_action :set_room

  def create
    @review = Review.new(review_params)
    @review.occupant = current_occupant
    @review.room = @room

    if @review.save
      render partial: "reviews/editable_review", locals: { room: @room, review: @review }
    else
      redirect_to room_url(@room), alert: "Review was not added.", status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)
   
    render partial: "reviews/editable_review", locals: { room: @room, review: @review }
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy

    render partial: "reviews/form", locals: { room: @room, review: Review.new, show_cancel_button: false }
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  def review_params
    params.require(:review).permit(:rating, :title, :comment, :room_id)
  end
end
