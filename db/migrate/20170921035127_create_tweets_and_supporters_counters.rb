class CreateTweetsAndSupportersCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets_and_supporters_counters do |t|
      t.string :need
      t.string :neighborhood
      t.integer :tweets_count, default: 0
      t.integer :supporters_count, default: 0
    end
  end
end
