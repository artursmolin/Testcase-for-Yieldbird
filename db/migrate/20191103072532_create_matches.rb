# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :result, null: false
      t.string :winner, null: false
      t.string :stage, null: false
      t.belongs_to :home_team, null: false
      t.belongs_to :guest_team, null: false
      t.belongs_to :tournament, null: false

      t.timestamps
    end
  end
end
