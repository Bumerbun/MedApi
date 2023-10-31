class Patient < ApplicationRecord
  has_many :consultation_requests
  has_many :request_recommendations, through: :consultation_requests
end
