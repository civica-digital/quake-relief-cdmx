class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :twitter_id
      t.string :author
      t.string :text

      t.timestamps
    end
  end
end
