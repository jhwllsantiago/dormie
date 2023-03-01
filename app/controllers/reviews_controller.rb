class ReviewsController < ApplicationController
  before_action :authenticate_occupant!
  before_action :set_room
  before_action :set_review, only: %i[ edit update destroy ]

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

  end

  def update
    if @review.update(review_params) 
      render partial: "reviews/editable_review", locals: { room: @room, review: @review }
    else
      render partial: "reviews/editable_review", locals: { room: @room, review: Review.find(@review.id) }
    end
  end

  def destroy
    @review.destroy

    render partial: "reviews/form", locals: { room: @room, review: Review.new, show_cancel_button: false }
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def review_params
    params.require(:review).permit(:rating, :title, :comment, :room_id)
  end
end
