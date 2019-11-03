# frozen_string_literal: true

class MatchesController < ApplicationController
  def create
    @team = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to new_tournament_team_path(@tournament)
    else
      render :new
    end
  end

  private

  def find_winner; end
end
