require_relative '../../lib/neighborhoods'

class Tweet < ApplicationRecord
  scope :by_neighborhood, -> (neighborhood) { by_keywords(Neighborhoods.find(neighborhood)) }
  scope :by_keywords, -> (keywords) {
    out = []
    keywords.each { |keyword|
      out << Tweet.where("text LIKE ?", "%#{keyword}%")
    }
    return out
  }
end
