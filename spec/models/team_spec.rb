require 'rails_helper'

RSpec.describe Team, type: :model do
  before do
    subject { build(:tournament) }
  end

  describe 'associations' do
    it { should belong_to(:tournament) }
    it { should belong_to(:division) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:division_points) }
  end
end
