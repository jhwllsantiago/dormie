require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let(:owner) {create(:owner)}
  let(:location) {create(:location, owner: owner)}

  describe "GET root" do
    it "is succesful" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET sign_in" do
    it "is succesful" do
      get sign_in_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET dashboard" do 
    context "owner signed in" do
      it "is succesful" do
        sign_in owner
        get dashboard_path
        expect(response).to have_http_status(200)
      end
    end

    context "owner signed in and have params" do
      it "is succesful and responds with turbo frame" do
        sign_in owner
        get dashboard_path(location: location.id)
        expect(response).to have_http_status(200)
        expect(response.body).to include('<turbo-frame id="dashboard_rooms_frame">')
      end
    end

    context "owner signed out" do
      it "redirects to new_owner_session" do
        get dashboard_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end
end
