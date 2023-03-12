class ReviewsController < ApplicationController
  before_action :authenticate_occupant!
  before_action :set_room
  before_action :set_review, :review_authorship, only: %i[ edit update destroy ]
  before_action :new_review_authorship, only: %i[ create ]

  def create
    @review = Review.new(review_params)
    @review.occupant = current_occupant
    @review.room = @room

    if @review.save
      render partial: "reviews/editable_review", locals: { room: @room, review: @review }
    else
      redirect_to room_path(@room), status: 302
    end
  end

  def edit
  end

  def update
    if @review.update(review_params) 
      render partial: "reviews/editable_review", locals: { room: @room, review: @review }
    else
      render partial: "reviews/editable_review", locals: { room: @room, review: Review.find(@review.id) }, status: 302
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

  def new_review_authorship
    redirect_to root_path if @room.owner.email == current_occupant.email
  end

  def review_authorship
    redirect_to root_path if @review.occupant != current_occupant
  end

  def set_review
    @review = Review.find(params[:review_id])
  end

  def review_params
    params.require(:review).permit(:rating, :title, :comment, :room_id)
  end
end
