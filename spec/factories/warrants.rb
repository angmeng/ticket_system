# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :warrant do
    code "MyString"
    name "MyString"
    address "MyText"
    phone "MyString"
    fax "MyString"
    email "MyString"
    remark "MyText"
    active false
  end
end
