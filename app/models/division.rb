# frozen_string_literal: true

class Division < ApplicationRecord
  has_many :teams
  belongs_to :tournament

  validates :name, presence: true, inclusion: { in: %w[A B] }
  validates :tournament_id, presence: true
end
