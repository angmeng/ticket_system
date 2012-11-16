# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    routine_id 1
    ticket_category_id 1
    code "MyString"
    name "MyString"
    initial_number 1
    fare "9.99"
    inventory_count false
    required_passenger false
    valid_from "2012-11-15"
    expired_at "2012-11-15"
    no_expired false
    active false
  end
end
