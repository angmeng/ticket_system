# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agent do
    username "MyString"
    fullname "MyString"
    agent_group_id 1
    branch_id 1
    phone "MyString"
    fax "MyString"
    email "MyString"
    remark "MyText"
    active false
  end
end
