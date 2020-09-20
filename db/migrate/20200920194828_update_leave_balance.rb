class UpdateLeaveBalance < ActiveRecord::Migration[6.0]
  def change
    change_column :absence_types, :leave_balance, :numeric
  end
end
