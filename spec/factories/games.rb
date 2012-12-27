# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    user_id 1
    final_score 1
    completed_at "2012-12-27 15:22:45"
  end
end
