class CreateStreamingPlatforms < ActiveRecord::Migration[7.1]
  def change
    create_table :streaming_platforms do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
