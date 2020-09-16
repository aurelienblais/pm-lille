class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.string :name
    end

    add_reference :agents, :rank
  end
end
