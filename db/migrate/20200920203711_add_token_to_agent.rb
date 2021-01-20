# frozen_string_literal: true

class AddTokenToAgent < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :token, :string
  end
end
