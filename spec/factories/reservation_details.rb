# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation_detail do
    reservation_number "MyString"
    order_id 1
  end
end
