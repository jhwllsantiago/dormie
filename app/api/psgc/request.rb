module Psgc
  class Request
    BASE_URL = "https://psgc.gitlab.io/api"

    def self.call endpoint
      result = Faraday.get("#{BASE_URL}#{endpoint}")
      JSON.parse(result.body)
    end
  end
end