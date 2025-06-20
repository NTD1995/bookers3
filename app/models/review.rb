class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }  
end
