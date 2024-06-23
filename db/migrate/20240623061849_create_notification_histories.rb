class CreateNotificationHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_histories do |t|

      t.timestamps
    end
  end
end
