# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item do
    order_id 1
    ticket_id 1
    departure_id 1
  end
end
