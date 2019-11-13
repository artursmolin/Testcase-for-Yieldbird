# frozen_string_literal: true

class DivisionsController < ApplicationController
  before_action :find_tournament
  before_action :round_robined?

  def index; end

  def round_robin
    RoundRobinService.new(@tournament).go
    redirect_to tournament_divisions_path(@tournament)
  end

  def find_division_winner; end

  def find_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def round_robined?
    @round_robined = @tournament.teams.pluck(:division_points).sum.positive? ? true : false
  end
end
