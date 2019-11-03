# frozen_string_literal: true

class DivisionsController < ApplicationController
  before_action :find_tournament
  before_action :round_robined?

  def index; end

  def round_robin
    @tournament.divisions.each do |division|
      array = division.teams.pluck(:name)
      array.push nil if array.size.odd?
      n = array.size
      pivot = array.pop
      games = (n - 1).times.map do
        array.rotate!
        [[array.first, pivot]] + (1...(n / 2)).map { |j| [array[j], array[n - 1 - j]] }
      end
      array.push pivot unless pivot.nil?
      games.each do |round|
        round.each do |game|
          home_team = Team.find_by(name: game.first)
          guest_team = Team.find_by(name: game.second)
          home_score = rand(1..10)
          guest_score = rand(1..10)
          result = "#{home_score} : #{guest_score}"
          if home_score > guest_score
            winner = home_team
            home_team.division_points += 1
            home_team.save
          elsif guest_score > home_score
            winner = guest_team
            guest_team.division_points += 1
            guest_team.save
          elsif home_score == guest_score
            winner = 'none'
            guest_team.division_points += 0.5
            home_team.division_points += 0.5
            guest_team.save && home_team.save
          end
          @tournament.matches.create(result: result,
                                     winner: winner,
                                     home_team_id: home_team.id,
                                     guest_team_id: guest_team.id,
                                     stage: 'division')
        end
      end
    end
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
