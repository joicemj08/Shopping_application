FactoryGirl.define do
  factory :user do |f|
    f.first_name 'joice'
    f.last_name 'joseph'
    f.email 'joice4u4@gmail.com'
    f.password 'joice4u4@gmail.com'
    f.confirmed_at Date.today
  end
end
