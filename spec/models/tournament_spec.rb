require 'rails_helper'
require 'spec_helper'

RSpec.describe Tournament, type: :model do
  before do
    subject { build(:tournament) }
  end

  describe 'associations' do
    it { should have_many(:teams) }
    it { should have_many(:matches) }
    it { should have_many(:divisions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
