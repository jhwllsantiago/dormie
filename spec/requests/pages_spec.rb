require 'rails_helper'

RSpec.describe "Pages", type: :request do
  context "user is not signed in" do
    describe "GET /root" do
      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET /sign_in" do
      it "returns http success" do
        get sign_in_path
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET /dashboard" do
      it "redirects to /owners/sign_in" do
        get dashboard_path
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end

  context "user is signed in" do
    let(:user) {create(:owner)}
    it "returns http success" do
      sign_in user
      get dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
