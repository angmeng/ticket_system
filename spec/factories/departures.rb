# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :departure do
    vessel_id 1
    sales_quota 1
    online_quota 1
    custom_quota 1
    on_call false
    status_id 1
    active false
  end
end
