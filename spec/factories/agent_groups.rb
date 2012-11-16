# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agent_group do
    code "MyString"
    name "MyString"
    active false
  end
end
