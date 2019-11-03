require 'rails_helper'

RSpec.describe Division, type: :model do
  before do
    subject { build(:division) }
  end

  describe 'associations' do
    it { should have_many(:teams) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:tournament_id) }
    it { should validate_inclusion_of(:name).in_array(%w[A B]) }
  end
end
