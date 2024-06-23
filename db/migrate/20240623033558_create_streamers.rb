class CreateStreamers < ActiveRecord::Migration[7.1]
  def change
    create_table :streamers do |t|
      t.references :talent, null: false, foreign_key: false, index: false
      t.references :streaming_platform, null: false, foreign_key: false, index: false
      t.string :streamer_key, null: false

      t.timestamps
    end
  end
end
