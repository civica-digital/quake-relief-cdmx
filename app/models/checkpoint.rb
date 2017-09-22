class Checkpoint < ApplicationRecord
  scope :by_neighborhood, -> (name) { where(neighborhood: name) }
  scope :by_need, -> (need) { where(need: need) }
end
