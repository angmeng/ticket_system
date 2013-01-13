# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :passenger do
    title "MyString"
    fullname "MyString"
    date_of_birth "2013-01-13"
    travel_document "MyString"
    issuing_country "MyString"
    document_no "MyString"
    expiration_date "2013-01-13"
  end
end
