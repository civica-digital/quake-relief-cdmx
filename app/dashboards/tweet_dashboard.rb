require "administrate/base_dashboard"

class TweetDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    twitter_id: Field::String,
    author: Field::String,
    text: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    url: Field::String,
    lat: Field::Number.with_options(decimals: 2),
    lng: Field::Number.with_options(decimals: 2),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :twitter_id,
    :author,
    :text,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :twitter_id,
    :author,
    :text,
    :created_at,
    :updated_at,
    :url,
    :lat,
    :lng,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :twitter_id,
    :author,
    :text,
    :url,
    :lat,
    :lng,
  ].freeze

  # Overwrite this method to customize how tweets are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tweet)
  #   "Tweet ##{tweet.id}"
  # end
end
