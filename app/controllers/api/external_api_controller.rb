require 'net/http'
module Api
  class ExternalApiController < ApplicationController
    @@api_link = "https://api.fda.gov"
    def index
      uri = URI("#{@@api_link}/#{params[:endpoint]}/#{params[:data]}.json")
      query = "?"
      request.query_parameters.each do |param|
        query = query + "#{param[0]}=#{param[1]}&"
      end
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      new_request = Net::HTTP::Get.new(uri+query)
      response = http.request(new_request)
      render json: {"test": test,"data": response.body }
    end
  end
end