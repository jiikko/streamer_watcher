class CreateStreamings < ActiveRecord::Migration[7.1]
  def change
    create_table :streamings do |t|
      t.string :title, null: false
      t.string :unique_key, null: false
      t.integer :streamer_id, null: false
      t.datetime :start_at, null: false
      t.boolean :notified, default: false, null: false
      t.integer :status, default: 0, null: false

      t.index %i[streamer_id unique_key], unique: true

      t.timestamps
    end
  end
end
