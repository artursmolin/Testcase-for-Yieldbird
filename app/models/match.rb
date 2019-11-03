# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :guest_team, class_name: 'Team'
  belongs_to :tournament

  validates :tournament_id, presence: true
  validates :guest_team_id, presence: true
  validates :home_team_id, presence: true
  validates :stage, presence: true
  validates :winner, presence: true
  validates :result, presence: true
end
