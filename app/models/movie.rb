class Movie < ApplicationRecord
  belongs_to :user

  enum :accessibility, { self: 0, for_all: 1 }, validate: true

  validates_presence_of :name, :user_id, :accessibility
end
