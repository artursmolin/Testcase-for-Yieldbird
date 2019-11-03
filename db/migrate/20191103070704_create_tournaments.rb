# frozen_string_literal: true

class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, unique: true, null: false
      t.string :winner

      t.timestamps
    end
  end
end
