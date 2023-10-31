class CreateRequestRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :request_recommendations do |t|
      t.belongs_to :consultation_request, null: false, foreign_key: true
      t.text :text, null: false
    end
  end
end
