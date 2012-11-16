class Ticket < ActiveRecord::Base
  attr_accessible :active, :code, :expired_at, :fare, :initial_number, :inventory_count, :name, :no_expired, :required_passenger, :routine_id, :ticket_category_id, :valid_from
end
