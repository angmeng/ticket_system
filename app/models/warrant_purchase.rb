class WarrantPurchase < ActiveRecord::Base
  attr_accessible :order_id, :warrant_id

  belongs_to :warrant
  belongs_to :order
end
