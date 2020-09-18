# frozen_string_literal: true

class UpdateDefaultUserRole < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :role, :disabled
  end
end
