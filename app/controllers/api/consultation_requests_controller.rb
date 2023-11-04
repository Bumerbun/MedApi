module Api
  class ConsultationRequestsController < ApplicationController
    VALIDATOR = ConsultationRequestContract.new
    def index
      requests = ConsultationRequest.all
      final_json = ResponseFormHelper.new
                                     .set_status(:success)
                                     .add_extra("found_data", requests)
                                     .result
      render json: final_json[:data], status: final_json[:status]
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