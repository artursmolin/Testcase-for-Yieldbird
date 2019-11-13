# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    name { 'New Tournament' }
    winner { 'Team 1' }
  end
end
