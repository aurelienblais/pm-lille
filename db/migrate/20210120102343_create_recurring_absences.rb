# frozen_string_literal: true

class CreateRecurringAbsences < ActiveRecord::Migration[6.0]
  def change
    create_table :recurring_absences do |t|
      t.references :agent
      t.references :absence_type

      t.date :start_date
      t.date :end_date

      t.integer :periodicity
    end
  end
end
