class ReadingStatus < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: { want_to_read: 0, reading: 1, read: 2 }
end
