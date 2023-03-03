require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let(:owner) {create(:owner)}
  let(:location) {create(:location, owner: owner)}
  let(:room) {create(:room, location: location)}
  let(:params) {{ name: "room name", description: "description", rent: 3000,
    capacity: 5, vacancies: 5, location: location }}

  describe "GET rooms" do
    it "is successful" do
      get rooms_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET room" do
    it "is successful" do
      get room_path(room)
      expect(response).to have_http_status(200)
    end
  end

  context "owner signed in" do
    before {sign_in owner}

    describe "GET new_room" do
      it "is successful" do
        get new_room_path
        expect(response).to have_http_status(200)
      end
    end

    describe "POST new_room" do
      it "redirects to room with valid params" do
        post rooms_path(room: params)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(room_path(room.id - 1))
      end

      it "redirects to new_room with invalid params" do
        post rooms_path(room: params.update(name: nil))
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_room_path)
      end
    end

    describe "GET edit_room" do
      it "is successful" do
        get edit_room_path(room)
        expect(response).to have_http_status(200)
      end
    end

    describe "PATCH room" do
      it "redirects to room with valid params" do
        patch room_path(room, room: params)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(room_path(room))
      end

      it "redirects to new_room with invalid params" do
        patch room_path(room, room: params)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(room_path(room))
      end
    end

    describe "DELETE room" do
      it "is successful" do
        delete room_path(room)
        expect(response).to have_http_status(200)
      end
    end
  end
end
