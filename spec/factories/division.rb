# frozen_string_literal: true

FactoryBot.define do
  factory :division do
    name { 'A' }
    association :tournament, factory: :tournament
  end
end
