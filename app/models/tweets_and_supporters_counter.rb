class TweetsAndSupportersCounter < ApplicationRecord
  scope :top_needs, -> (limit) { order(tweets_count: :desc).limit(limit) }
  scope :by_neighborhood, -> (name) { where(neighborhood: name) }
  scope :by_need, -> (need) { where(need: need) }
end
