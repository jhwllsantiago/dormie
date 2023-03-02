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
    Owner.destroy_all
    user = Owner.new(
      name: "John Doe",
      contact: "09123123123",
      email: "johndoe@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.skip_confirmation!
    user.save!

    it "returns http success" do
      sign_in user
      get dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
