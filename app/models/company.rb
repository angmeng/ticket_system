class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :email, :fax, :name, :phone, :register_number, :branch_id, :discount_on_two_way_ticket,  :last_voucher_number, :last_receipt_number, :last_reservation_number
  
  belongs_to :branch

  validates :name, :register_number, :presence => true, :uniqueness => true

  validate :check_validation, :on => :create

  private

  def check_validation
  	if Company.first
      errors.add(:name, "only can have one company in the system")
  	end
  end
end
