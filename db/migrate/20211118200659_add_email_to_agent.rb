# frozen_string_literal: true

class AddEmailToAgent < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :email, :string
  end
end
