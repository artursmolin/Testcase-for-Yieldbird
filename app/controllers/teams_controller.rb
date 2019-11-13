# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :find_tournament

  def new; end

  def create
    @divisions = []
    ('A'..'B').each { |name| @divisions.push(@tournament.divisions.create!(name: name)) }
    result = Teams::Create.new.call(@tournament, @divisions, teams_params)
    if result.eql?(true)
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
