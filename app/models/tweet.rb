require_relative '../../lib/neighborhoods'

class Tweet < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_keyword,
    against: :text,
    using: [:tsearch, :trigram],
    ignoring: :accents

  scope :search_by_neighborhood, -> (neighborhood) {
    self.search_by_keywords(Neighborhoods.find(neighborhood))
  }

  def search_by_keywords(keywords)
    keywords.each do |x|
      result = search_by_keyword(x)
    end
  end

  scope :search_by_keywords, -> (keywords) {

    matches = keywords.map { |k| self.search_by_keyword(k) }
    matches.flatten
  }
end
