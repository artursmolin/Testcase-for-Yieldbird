# frozen_string_literal: true

class RoundRobinService
  attr_reader :tournament

  def initialize(tournament)
    @tournament = tournament
  end

  def go
    tournament.divisions.each do |division|
      round(division)
    end
  end

  def round(division)
    array = division.teams.pluck(:name)
    array.push nil if array.size.odd?
    pivot = array.pop
    games = games_schedule(array, pivot)
    array.push pivot unless pivot.nil?
    games.each do |round|
      PlayMatchService.new(@tournament, round, 'division').play
    end
  end

  def games_schedule(array, pivot)
    n = array.size
    (n - 1).times.map do
      array.rotate!
      [[array.first, pivot]] + (1...(n / 2)).map { |j| [array[j], array[n - 1 - j]] }
    end
  end
end
