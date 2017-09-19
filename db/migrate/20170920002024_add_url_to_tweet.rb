class AddUrlToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :url, :string
  end
end
