class ReadingLog < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :read_on, presence: true
end
