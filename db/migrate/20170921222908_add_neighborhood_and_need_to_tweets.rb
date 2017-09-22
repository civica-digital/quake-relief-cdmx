class AddNeighborhoodAndNeedToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :neighborhood, :string
    add_column :tweets, :needs, :text, array: true, default: []
  end
end
