require 'rails_helper'

RSpec.describe "Locations", type: :request do
  let(:owner) {create(:owner)}
  let(:location) {create(:location, owner: owner)}
  let(:params)  {{name: "location name", address_line: "address_line", city: "city",
    province: "province", latitude: 12.8797, longitude: 121.7740, owner: owner}}
  before {sign_in owner}

  describe "GET new_location" do
    it "is successful" do
      get new_location_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST locations" do
    it "redirects to dashboard with valid params" do
      post locations_path(location: params)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to new_location with invalid params" do
      post locations_path(location: params.update(name: nil))
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_location_path)
    end
  end

  describe "DELETE location" do
    it "is successful" do
      delete location_path(location), as: :turbo_stream
      expect(response).to have_http_status(200)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include("<turbo-stream action=\"remove\" target=\"location_#{location.id}\">")
    end
  end
end
