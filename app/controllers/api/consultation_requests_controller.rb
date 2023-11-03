module Api
  class ConsultationRequestsController < ApplicationController
    @@validator = ConsultationRequestContract.new
    def index
      requests = ConsultationRequest.all
      render json: {status: "SUCCESS", data: requests }, status: :ok
    end
    def create
      CreationHelper.create(self, request_params.to_h, ConsultationRequest, @@validator)
    end

    def request_params
      params.permit :patient_id, :text
    end
  end
end