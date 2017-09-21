class CreateTweetsAndSupportersCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets_and_supporters_counters do |t|
      t.string :need
      t.string :neighborhood
      t.integer :tweets_count
      t.integer :supporters_count
    end
  end
end
