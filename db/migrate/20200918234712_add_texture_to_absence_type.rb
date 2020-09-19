class AddTextureToAbsenceType < ActiveRecord::Migration[6.0]
  def change
    add_column :absence_types, :texture, :string
  end
end
