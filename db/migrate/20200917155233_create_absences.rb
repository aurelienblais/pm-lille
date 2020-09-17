class CreateAbsences < ActiveRecord::Migration[6.0]
  def change
    create_table :absences do |t|
      t.references :agent
      t.references :absence_type

      t.string :date
    end
  end
end
