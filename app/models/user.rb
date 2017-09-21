class User < ApplicationRecord
  has_and_belongs_to_many

  has_many :supported_needs, through: :support
  belongs_to :need
end
