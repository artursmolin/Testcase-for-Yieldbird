# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :find_tournament, except: %i[new create]
  before_action :find_bo_8, only: %i[playoff bo4]
  before_action :find_bo_4, only: %i[quarterfinals bo2]
  before_action :find_bo_2, only: %i[semifinals bo1]
  before_action :find_winner, only: [:final]

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to new_tournament_team_path(@tournament)
    else
      render :new
    end
  end

  def destroy
    if @tournament.destroy
      redirect_to root_path
    else
      render :final
    end
  end

  def playoff; end

  def quarterfinals; end

  def semifinals; end

  def final; end

  def bo4
    if PlayMatchService.new(@tournament, @playoff_games, 'quarterfinal').play
      redirect_to tournament_quarterfinals_path
    else
      render :playoff
    end
  end

  def bo2
    if PlayMatchService.new(@tournament, @playoff_games, 'semifinal').play
      redirect_to tournament_semifinals_path
    else
      render :quarterfinals
    end
  end

  def bo1
    if PlayMatchService.new(@tournament, @playoff_games, 'final').play
      redirect_to tournament_final_path
    else
      render :semifinals
    end
  end

  private

  def tournament_params
    params[:tournament].permit(:name)
  end

  def find_tournament
    @tournament = params[:id].present? ? Tournament.find(params[:id]) : Tournament.find(params[:tournament_id])
  end

  def find_bo_8
    stage = 'playoff'
    @playoff_games = EliminationService.new(stage).playoff_games(@tournament)
  end

  def find_bo_4
    stage = 'quarterfinals'
    @quarterfinals = find_quarterfinal_matches
    @playoff_games = EliminationService.new(stage).schedule(@quarterfinals)
  end

  def find_bo_2
    stage = 'semifinals'
    @quarterfinals = find_quarterfinal_matches
    @semifinals = find_semifinal_matches
    @playoff_games = EliminationService.new(stage).schedule(@semifinals)
  end

  def find_winner
    @quarterfinals = find_quarterfinal_matches
    @semifinals = find_semifinal_matches
    @final = find_final_match
    @winner = Team.find(find_final_match.winner)
  end

  def find_quarterfinal_matches
    @tournament.matches.where(stage: 'quarterfinal')
  end

  def find_semifinal_matches
    @tournament.matches.where(stage: 'semifinal')
  end

  def find_final_match
    @tournament.matches.where(stage: 'final').first
  end
end
