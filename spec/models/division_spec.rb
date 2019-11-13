# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Division, type: :model do
  before do
    subject { build(:division) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:teams) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:tournament_id) }
    it { is_expected.to validate_inclusion_of(:name).in_array(%w[A B]) }
  end
end
