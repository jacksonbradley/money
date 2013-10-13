FactoryGirl.define do
  factory :user do
    email 'a@a.com'
    password 'a1234567'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end