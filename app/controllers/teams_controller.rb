# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :find_tournament

  def new; end

  def create
    @teams = []
    @divisions = []
    ('A'..'B').each { |name| @divisions.push(@tournament.divisions.create!(name: name)) }
    teams_params.shuffle.each_with_index do |team_params, index|
      team = @tournament.teams.build(team_params)
      team.division_id = index.odd? ? @divisions.first.id : @divisions.second.id
      @teams.push(team)
    end
    if @teams.count.eql?(16) && @teams.each(&:save)
      redirect_to tournament_divisions_path
    else
      render :new
    end
  end

  def teams_params
    params[:teams].map { |team| team.permit(:name) }
  end

  def find_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end
end
