class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence:true, length: {maximum:200}


  # 特定のユーザーが投稿をいいねしているか判断
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
