# frozen_string_literal: true

class AddStatusToAbsenceType < ActiveRecord::Migration[6.1]
  def change
    add_column :absence_types, :status, :string, default: :visible
  end
end
