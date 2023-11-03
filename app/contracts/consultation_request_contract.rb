
class ConsultationRequestContract < Dry::Validation::Contract
  params do
    required(:patient_id).filled(:integer)
    required(:text).filled(:string)
  end

  rule(:patient_id) do
    key.failure("Patient with this id doesnt exist") unless ConsultationRequest.find(value)
  end
end