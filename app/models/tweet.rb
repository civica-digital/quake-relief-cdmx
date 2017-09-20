require_relative '../../lib/neighborhoods'

class Tweet < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_keyword, :against => :text

  scope :search_by_neighborhood, -> (neighborhood) {
    search_by_keywords(Neighborhoods.find(neighborhood))
  }
  scope :search_by_keywords, -> (keywords) {
    matches = keywords.map { |k| Tweet.search_by_keyword(k) }
    matches.flatten
  }
end
