# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do
  render_views

  let(:tournament) { create(:tournament) }
  let(:team) { create(:team, tournament: tournament) }
  let(:division) { create(:division, tournament: tournament) }


  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { name: 'Tournament1' }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Tournament' do
        expect(Tournament.count).eql?(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested tournament and dependent models' do
      expect(Tournament.count).eql?(0)
      expect(Division.count).eql?(0)
      expect(Match.count).eql?(0)
      expect(Team.count).eql?(0)
    end
  end
end
