class CreateTalents < ActiveRecord::Migration[7.1]
  def change
    create_table :talents do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
