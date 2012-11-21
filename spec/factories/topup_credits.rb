# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topup_credit do
    agent_id 1
    amount "9.99"
    remark "MyText"
    staff_id 1
  end
end
