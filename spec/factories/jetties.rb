# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jetty do
    code "MyString"
    name "MyString"
    active false
  end
end
