module Teams
  class Create
    def call(tournament, divisions, teams_params)
      @teams = Teams::Create.new.create(tournament, divisions, teams_params)
      @teams.count.eql?(16) && @teams.each(&:save) ? true : false
    end

    def create(tournament, divisions, teams_params)
      teams = []
      teams_params.shuffle.each_with_index do |team_params, index|
        team = tournament.teams.build(team_params)
        team.division_id = index.odd? ? divisions.first.id : divisions.second.id
        teams.push(team)
      end
      teams
    end
  end
end
