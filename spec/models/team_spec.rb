# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  before do
    subject { build(:tournament) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to belong_to(:division) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:division_points) }
  end
end
