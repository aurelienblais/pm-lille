class AddDisplayStatisticToAbsenceType < ActiveRecord::Migration[6.0]
  def change
    add_column :absence_types, :display_statistic, :boolean, default: true
  end
end
