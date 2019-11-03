FactoryBot.define do
  factory :match do
    result { '5 : 8'}
    winner { "Team 1" }
    stage { 'division' }
    association :home_team_team_id, factory: :team
    association :guest_team_id, factory: :team
    association :tournament_id, factory: :tournament
  end
end