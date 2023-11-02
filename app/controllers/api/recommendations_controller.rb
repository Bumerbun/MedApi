

module Api
  class RecommendationsController < ApplicationController
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
      recommendation = RequestRecommendation.new(recommendation_params)
      if recommendation.save
        render json: {status: "SUCCESS", message: "Recommendation for consultation request created"}, status: :created
      else
        render json: {status: "FAILURE", message: "Request could not be saved"}, status: :bad_request
      end
    end

    def recommendation_params
      params.permit(:consultation_request_id, :text)
    end

    def send_email(email, subject, text)
      message = <<MESSAGE_END
      From: TestAPI <>
MESSAGE_END
    end
  end
end