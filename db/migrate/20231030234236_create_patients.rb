class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name, limit: 100, null: false
      t.string :surname, limit: 100, null: false
      t.string :patronymic, limit: 100, null: false
      t.string :phone, limit: 11, null: false
      t.string :email, null: false
    end
  end
end
