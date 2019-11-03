FactoryBot.define do
  factory :team do
    name { "Team 1" }
    division_points { 8 }
    association :division_id, factory: :division
    association :tournament_id, factory: :tournament
  end
end