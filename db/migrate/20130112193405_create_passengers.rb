class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :title
      t.string :fullname
      t.date :date_of_birth
      t.string :travel_document
      t.string :issuing_country
      t.string :document_no
      t.date :expiration_date
      t.integer :order_id

      t.timestamps
    end
    add_index :passengers, :order_id
  end
end
