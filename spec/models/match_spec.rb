# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  before do
    subject { build(:match) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:home_team).class_name('Team') }
    it { is_expected.to belong_to(:guest_team).class_name('Team') }
    it { is_expected.to belong_to(:tournament) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:home_team_id) }
    it { is_expected.to validate_presence_of(:guest_team_id) }
    it { is_expected.to validate_presence_of(:tournament_id) }
    it { is_expected.to validate_presence_of(:winner) }
    it { is_expected.to validate_presence_of(:stage) }
    it { is_expected.to validate_presence_of(:result) }
  end
end
