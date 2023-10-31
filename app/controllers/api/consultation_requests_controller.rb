module Api
  class ConsultationRequestsController < ApplicationController
    def index
      requests = ConsultationRequest.all
      render json: {status: "SUCCESS", data: requests }, status: :ok
    end
    def create
      request = ConsultationRequest.new(request_params)
      if request.save
        render json: {status: "SUCCESS", message: "Consultation request created"}, status: :created
      else
        render json: {status: "FAILURE", message: "Request could not be saved"}, status: :bad_request
      end
    end

    def request_params
      params.permit :patient_id, :text
    end
  end
end