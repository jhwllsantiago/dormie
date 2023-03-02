require 'rails_helper'

RSpec.describe "Maps", type: :request do
  describe "GET results_map" do
    it "is succesful" do
      get results_map_path
      expect(response).to be_successful
    end
  end

  context "owner is signed in" do
    let(:owner) {create(:owner)}
    before { sign_in owner }

    describe "GET location_map" do
      let(:location) {create(:location, owner: owner)}
      it "raises an error if location does not exist" do
        expect { get location_map_path(0) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "is succesful and responds with turbo frame" do
        get location_map_path(location.id)
        expect(response).to be_successful
        expect(response.body).to include('<turbo-frame id="location_map_frame">')
      end
    end

    describe "GET marker_map" do
      it "is succesful" do
        get marker_map_path
        expect(response).to be_successful
      end
    end
  end

  context "owner is not signed in" do
    describe "GET location_map" do
      it "redirects to new_owner_session" do
        get location_map_path(1)
        expect(response).to redirect_to(new_owner_session_path)
      end
    end

    describe "GET marker_map" do
      it "redirects to new_owner_session" do
        get marker_map_path
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end
end
