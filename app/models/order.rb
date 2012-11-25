class Order < ActiveRecord::Base
  attr_accessible :amount_tender, :discount, :extra_charges, :free_tickets, :payment_type_id, :remark, :user_id
end
