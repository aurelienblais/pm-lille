# frozen_string_literal: true

class AddLeaveBalanceToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :leave_balance, :integer, default: 35
    add_column :absence_types, :leave_balance, :integer, default: 0
  end
end
