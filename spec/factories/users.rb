FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    factory :admin do
        after(:create) {|user| user.add_role(:admin)}
    end
  end
end