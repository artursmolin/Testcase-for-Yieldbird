# frozen_string_literal: true

class PlayMatchService
  attr_reader :matches, :stage, :results, :tournament

  def initialize(tournament, matches, stage)
    @matches = matches
    @stage = stage
    @results = []
    @tournament = tournament
  end

  def play
    matches.each do |game|
      home_team = stage.eql?('division') ? Team.find_by(name: game.first) : Team.find(game.first.id)
      guest_team = stage.eql?('division') ? Team.find_by(name: game.second) : Team.find(game.second.id)
      result = play_match(home_team, guest_team)
      results.push(tournament.matches.create(result: result[:score],
                                             winner: result[:winner],
                                             home_team_id: home_team.id,
                                             guest_team_id: guest_team.id,
                                             stage: stage))
    end
  end

  def play_match(home_team, guest_team)
    guest_score = rand(1..10)
    home_score = rand(1..10)
    if home_score > guest_score
      winner = home_team
    elsif guest_score > home_score
      winner = guest_team
    elsif home_score == guest_score
      winner = [home_team, guest_team].sample
    end
    add_division_points(winner) if stage.eql?('division')
    result_hash = { score: "#{home_score} : #{guest_score}", winner: winner.id }
  end

  def add_division_points(team)
    points = team.division_points
    points += 1
    team.update(division_points: points)
  end
end
