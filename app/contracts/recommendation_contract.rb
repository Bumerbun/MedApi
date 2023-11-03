
class RecommendationContract < Dry::Validation::Contract
  params do
    required(:consultation_request_id).filled(:integer)
    required(:text).filled(:string)
  end

  rule(:consultation_request_id) do
    key.failure("Consultation request with this id doesnt exist") unless ConsultationRequest.find(value)
  end
end