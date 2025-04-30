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

  # Bookモデルのcontentカラムに対して検索
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(content: content)
    elsif method == 'forward'
      Book.where('content LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('content LIKE ?', '%' + content)
    else
      Book.where('content LIKE ?', '%' + content + '%')
    end
  end  
end
