require 'rails_helper'

RSpec.describe "Maps", type: :request do
  let(:owner) {create(:owner)}
  let(:location) {create(:location, owner: owner)}

  describe "GET results_map" do
    it "is succesful" do
      get results_map_path
      expect(response).to have_http_status(200)
    end
  end

  context "owner signed in" do
    before { sign_in owner }

    describe "GET location_map" do
      it "is succesful and responds with turbo frame" do
        get location_map_path(location.id)
        expect(response).to have_http_status(200)
        expect(response.body).to include('<turbo-frame id="location_map_frame">')
      end
    end

    describe "GET marker_map" do
      it "is succesful" do
        get marker_map_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context "owner signed out" do
    describe "GET location_map" do
      it "redirects to new_owner_session" do
        get location_map_path(location)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_owner_session_path)
      end
    end

    describe "GET marker_map" do
      it "redirects to new_owner_session" do
        get marker_map_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end
end
