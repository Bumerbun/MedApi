

module Api
  class RecommendationsController < ApplicationController
    VALIDATOR = RecommendationContract.new
    def index
      recommendations = RequestRecommendation
      if params[:consultation_request_id]
        recommendations = recommendations.where consultation_request_id: params[:consultation_request_id]
      end
      if params[:patient_id]
        Patient.find(params[:patient_id]).request_recommendations
        recommendations = Patient.find(params[:patient_id]).request_recommendations
      end
      render json: {status: "SUCCESS", data: recommendations}, status: :ok
    end
    def create
      final_json = CreationHelper.create(recommendation_params.to_h, RequestRecommendation, VALIDATOR)
      unless final_json.result[:data][:status] == ResponseStatus.instance.validation_failure_literal
        final_json.add_extra( "email_status",
          send_email.as_json[:errors] ? ResponseStatus.instance.failure_literal : ResponseStatus.instance.success_literal)
      end
      final_json = final_json.result
      render json: final_json[:data], status: final_json[:status]
    end

    def recommendation_params
      params.permit(:consultation_request_id, :text)
    end

    def send_email
      patient_id = ConsultationRequest.find(params[:consultation_request_id]).patient_id
      patient_email = Patient.find(patient_id).email
      UserMailer.new_recommendation(patient_email, params[:text]).deliver_now
    end
  end
end