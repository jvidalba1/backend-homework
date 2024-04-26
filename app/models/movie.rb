class Movie < ApplicationRecord
  belongs_to :user

  scope :for_all, -> { where(accessibility: 1) }
  scope :for_self, -> (user_id) { where(user_id: user_id) }

  enum :accessibility, { self: 0, for_all: 1 }, validate: true

  validates_presence_of :name, :user_id, :accessibility
end
