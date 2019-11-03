require 'rails_helper'

RSpec.describe Match, type: :model do
  before do
    subject { build(:match) }
  end

  describe 'associations' do
    it { should belong_to(:home_team).class_name('Team') }
    it { should belong_to(:guest_team).class_name('Team') }
    it { should belong_to(:tournament) }
  end

  describe 'validations' do
    it { should validate_presence_of(:home_team_id) }
    it { should validate_presence_of(:guest_team_id) }
    it { should validate_presence_of(:tournament_id) }
    it { should validate_presence_of(:winner) }
    it { should validate_presence_of(:stage) }
    it { should validate_presence_of(:result) }
  end
end
