# frozen_string_literal: true

class CreateAbsenceTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :absence_types do |t|
      t.string :name
      t.string :color
    end
  end
end
