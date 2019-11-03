# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :matches
  has_many :divisions
  has_many :teams

  validates :name, presence: true, uniqueness: true
end
