class Competitor < ApplicationRecord
  validates :name, presence: true

  scope :not_deleted, -> { where(deleted: false) }
end
