require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let(:owner) {create(:owner)}

  describe "GET root" do
    it "is succesful" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "GET sign_in" do
    it "is succesful" do
      get sign_in_path
      expect(response).to be_successful
    end
  end

  describe "GET dashboard" do 
    context "owner signed in" do
      it "is succesful" do
        sign_in owner
        get dashboard_path
        expect(response).to be_successful
      end
    end

    context "owner signed out" do
      it "redirects to new_owner_session" do
        get dashboard_path
        expect(response).to redirect_to(new_owner_session_path)
      end
    end
  end
end
