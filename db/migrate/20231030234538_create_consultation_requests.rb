class CreateConsultationRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :consultation_requests do |t|
      t.belongs_to :patient, null: false, foreign_key: true
      t.text :text, null: false
      t.datetime :created_at
    end
  end
end
