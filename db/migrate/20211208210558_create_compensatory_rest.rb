class CreateCompensatoryRest < ActiveRecord::Migration[6.0]
  def change
    create_table :compensatory_rests do |t|
      t.references :agent

      t.string :reason
      t.integer :amount

      t.timestamps
    end
  end
end
