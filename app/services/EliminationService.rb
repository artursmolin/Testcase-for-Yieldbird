# frozen_string_literal: true

class EliminationService
  attr_reader :stage

  def initialize(stage)
    @stage = stage
  end

  def playoff_games(tournament)
    best_teams = []
    tournament.divisions.each do |division|
      best_teams.push(division.teams.order(:division_points)[0..3])
    end
    @winners = [
      [best_teams.first[0], best_teams.second[3]],
      [best_teams.first[1], best_teams.second[2]],
      [best_teams.first[2], best_teams.second[1]],
      [best_teams.first[3], best_teams.second[0]]
    ]
  end

  def schedule(matches)
    best_teams = []
    matches.each do |match|
      best_teams.push(Team.find(match.winner))
    end
    @winners = case stage
               when 'quarterfinals'
                 [
                   [best_teams[0], best_teams[1]],
                   [best_teams[2], best_teams[3]]
                 ]
               when 'semifinals'
                 [
                   [best_teams[0], best_teams[1]]
                 ]
               end
  end
end
