class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :abbv

      t.timestamps
    end
  end
end
