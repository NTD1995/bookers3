class GroupMessage < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1000 }
end
