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
    if play_matches(@playoff_games, 'quarterfinal')
      redirect_to tournament_quarterfinals_path
    else
      render :playoff
    end
  end

  def bo2
    if play_matches(@playoff_games, 'semifinal')
      redirect_to tournament_semifinals_path
    else
      render :quarterfinals
    end
  end

  def bo1
    if play_matches(@playoff_games, 'final')
      redirect_to tournament_final_path
    else
      render :semifinals
    end
  end

  private

  def tournament_params
    params[:tournament].permit(:name)
  end

  def play_matches(matches, stage)
    results = []
    matches.each do |game|
      home_team = Team.find(game.first.id)
      guest_team = Team.find(game.second.id)
      guest_score = rand(1..10)
      home_score = rand(1..10)
      if home_score > guest_score
        winner = home_team.name
      elsif guest_score > home_score
        winner = guest_team.name
      elsif home_score == guest_score
        winner = [home_team, guest_team].sample.name
        winner.eql?(home_team) ? home_score + 1 : guest_score + 1
      end
      result = "#{home_score} : #{guest_score}"
      results.push(@tournament.matches.create(result: result,
                                              winner: winner,
                                              home_team_id: home_team.id,
                                              guest_team_id: guest_team.id,
                                              stage: stage))
    end
    results
  end

  def find_tournament
    @tournament = params[:id].present? ? Tournament.find(params[:id]) : Tournament.find(params[:tournament_id])
  end

  def find_bo_8
    bo_8 = []
    @tournament.divisions.each do |division|
      bo_8.push(division.teams.order(:division_points)[0..3])
    end
    @playoff_games = [
      [bo_8.first[0], bo_8.second[3]],
      [bo_8.first[1], bo_8.second[2]],
      [bo_8.first[2], bo_8.second[1]],
      [bo_8.first[3], bo_8.second[0]]
    ]
  end

  def find_bo_4
    bo_4 = []
    @quarterfinals = find_quarterfinal_matches
    @quarterfinals.each do |match|
      bo_4.push(Team.find_by(name: match.winner))
    end
    @playoff_games = [
      [bo_4[0], bo_4[1]],
      [bo_4[2], bo_4[3]]
    ]
  end

  def find_bo_2
    @quarterfinals = find_quarterfinal_matches
    @semifinals = find_semifinal_matches
    bo_2 = []
    @semifinals.each do |match|
      bo_2.push(Team.find_by(name: match.winner))
    end
    @playoff_games = [
      [bo_2[0], bo_2[1]]
    ]
  end

  def find_winner
    @quarterfinals = find_quarterfinal_matches
    @semifinals = find_semifinal_matches
    @final = find_final_match
    @winner = Team.find_by(name: find_final_match.winner)
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
