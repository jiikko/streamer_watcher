class CreateStreamings < ActiveRecord::Migration[7.1]
  def change
    create_table :streamings do |t|
      t.string :title, null: false
      t.integer :streaming_platform_id, null: false
      t.integer :talent_id, null: false
      t.datetime :start_at, null: false
      t.boolean :notified, default: false, null: false

      t.timestamps
    end
  end
end
