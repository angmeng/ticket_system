# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :staff do
    username "MyString"
    fullname "MyString"
    address "MyText"
    phone "MyString"
    email "MyString"
    type_id 1
    branch_id 1
    active false
  end
end
