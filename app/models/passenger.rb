class Passenger < ActiveRecord::Base
  attr_accessible :date_of_birth, :document_no, :expiration_date, :fullname, :issuing_country, :title, :travel_document, :order_id
  belongs_to :order

  validates :fullname, :title, :presence => true
end
