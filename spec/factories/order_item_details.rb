# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_item_detail do
    order_item_id 1
    serial_number "MyString"
    ticket_status_id 1
    fare "9.99"
    ticket_category_id 1
  end
end
