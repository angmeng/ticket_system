# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    code "MyString"
    departure_time "2012-11-15 01:39:41"
    routine_id 1
    sales_quota 1
    online_quota 1
    active false
  end
end
