# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vessel do
    code "MyString"
    name "MyString"
    total_passenger 1
    total_crew 1
    active false
  end
end
