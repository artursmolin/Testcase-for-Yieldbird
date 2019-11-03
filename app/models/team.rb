# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :tournament
  belongs_to :division

  validates :name, presence: true
  validates :division_points, presence: true
  validates :tournament_id, presence: true
  validates :division_id, presence: true
end
