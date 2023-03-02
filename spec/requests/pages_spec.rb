require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET root" do
    it "is succesful" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "GET sign_in" do
    it "returns http success" do
      get sign_in_path
      expect(response).to be_successful
    end
  end

  describe "GET dashboard" do 
    context "user is signed in" do
      let(:user) {create(:owner)}
      it "returns http success" do
        sign_in user
        get dashboard_path
        expect(response).to be_successful
      end
    end

    context "user is not signed in" do
      it "redirects to new_owner_session_path" do
        get dashboard_path
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end
end
