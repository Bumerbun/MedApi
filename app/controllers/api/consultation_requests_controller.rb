module Api
  class ConsultationRequestsController < ApplicationController
    VALIDATOR = ConsultationRequestContract.new
    def index
      requests = ConsultationRequest.all
      render json: {status: "SUCCESS", data: requests}, status: :ok
    end
    def create
      final_json = CreationHelper.create(request_params.to_h, ConsultationRequest, VALIDATOR).result
      render json: final_json[:data], status: final_json[:status]
    end

    def request_params
      params.permit :patient_id, :text
    end
  end
end