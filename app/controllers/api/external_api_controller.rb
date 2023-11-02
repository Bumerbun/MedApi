require 'net/http'
module Api
  class ExternalApiController < ApplicationController
    @@api_link = "https://api.fda.gov"
    def index
      uri = URI("#{@@api_link}/#{params[:endpoint]}/#{params[:data]}.json")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      query = "?"
      request.query_parameters.each do |param|
        query = query + "#{param[0]}=#{param[1]}&"
      end

      new_request = Net::HTTP::Get.new(uri+query)
      response = http.request(new_request)

      if response.code == "200"
        render json: {"status": "SUCCESS", "data": JSON.parse(response.body) }, status: :ok
      else
        render json: {"status": "FAILURE", "message": "Endpoint is not reachable or invalid query", "data": JSON.parse(response.body)}, status: :bad_request
      end
    end
  end
end