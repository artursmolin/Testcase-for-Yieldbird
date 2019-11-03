# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  render_views

  let(:tournament) { create(:tournament) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a 16 new teams' do
        expect(Team.count).eql?(16)
      end

      it 'creates 2 new divisions' do
        expect(Division.count).eql?(2)
      end
    end
  end
end
