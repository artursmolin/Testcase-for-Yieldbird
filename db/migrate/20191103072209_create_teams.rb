# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :division_points, default: 0
      t.belongs_to :tournament, null: false
      t.belongs_to :division, null: false

      t.timestamps
    end
  end
end
