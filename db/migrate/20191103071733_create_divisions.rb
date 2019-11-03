# frozen_string_literal: true

class CreateDivisions < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions do |t|
      t.string :name, null: false
      t.belongs_to :tournament, null: false

      t.timestamps
    end
  end
end
