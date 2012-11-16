# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :routine do
    code "MyString"
    departure_jetty_id 1
    arrival_jetty_id 1
    sequence_no 1
    active false
  end
end
