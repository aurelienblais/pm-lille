class AddAgentToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :agent
  end
end
