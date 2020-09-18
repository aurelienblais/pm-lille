# frozen_string_literal: true

class CreateAgent < ActiveRecord::Migration[6.0]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :register_number

      t.date :birthday
      t.date :arrival_date
      t.date :departure_date
    end
  end
end
