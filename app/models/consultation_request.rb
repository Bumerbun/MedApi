class ConsultationRequest < ApplicationRecord
  belongs_to :patient
  has_many :request_recommendations
end
