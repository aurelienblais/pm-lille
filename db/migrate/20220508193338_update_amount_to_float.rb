class UpdateAmountToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :compensatory_rests, :amount, :float
  end
end
