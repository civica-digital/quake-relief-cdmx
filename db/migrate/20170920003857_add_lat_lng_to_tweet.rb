class AddLatLngToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :lat, :float
    add_column :tweets, :lng, :float
  end
end
