require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:occupant) {create(:occupant)}
  let(:owner) {create(:owner)}
  let(:location) {create(:location, owner: owner)}
  let(:room) {create(:room, location: location)}
  let(:review) {create(:review, room: room, occupant: occupant)}
  let(:params) { {rating: 5, title: "title", comment: "comment", occupant: occupant, room: room} }
  before {sign_in occupant}

  describe "POST room_reviews" do
    it "is successful with valid params" do
      post room_reviews_path(room, review: params)
      expect(response).to have_http_status(200)
    end

    it "is not successful with invalid params" do
      post room_reviews_path(room, review: params.update(rating: 6))
      expect(response).to have_http_status(302)
      post room_reviews_path(room, review: params.update(title: nil))
      expect(response).to have_http_status(302)
      post room_reviews_path(room, review: params.update(comment: nil))
      expect(response).to have_http_status(302)
    end
  end

  describe "GET edit_room_review" do
    it "is successful" do
      get edit_room_review_path(room, review)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH room_review" do
    it "is successful with valid params" do
      patch room_review_path(room, review, review: params.update(rating: 4))
      expect(response).to have_http_status(200)
    end

    it "is not successful with invalid params" do
      patch room_review_path(room, review, review: params.update(rating: 6))
      expect(response).to have_http_status(302)
      patch room_review_path(room, review, review: params.update(title: nil))
      expect(response).to have_http_status(302)
      patch room_review_path(room, review, review: params.update(comment: nil))
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE room_review" do
    it "is successful" do
      delete room_review_path(room, review)
      expect(response).to have_http_status(200)
    end
  end

  context "occupant signed out" do
    describe "POST room_reviews" do
      it "redirects to new_occupant_session" do
        sign_out occupant
        post room_reviews_path(room, review: params)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_occupant_session_path)
      end
    end
  end
end
