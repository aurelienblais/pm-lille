# frozen_string_literal: true

class CreateUserTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_teams do |t|
      t.references :user
      t.references :team
    end
  end
end
