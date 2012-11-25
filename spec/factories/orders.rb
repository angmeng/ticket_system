# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user_id 1
    payment_type_id 1
    free_tickets 1
    discount "9.99"
    extra_charges "9.99"
    amount_tender "9.99"
    remark "MyText"
  end
end
