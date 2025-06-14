class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :reading_statuses 
  has_many :reading_books, through: :reading_statuses, source: :book
  has_one_attached :profile_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :view_counts, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id", dependent: :destroy
  has_many :group_messages, dependent: :destroy 
  has_many :notifications, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_books, through: :bookmarks, source: :book
  has_many :posted_books, class_name: 'Book', foreign_key: 'user_id', dependent: :destroy
  has_many :reading_logs, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true , presence: true
  validates :introduction, length: { maximum: 50 }

  # プロフィール画像取得、リサイズする
  def get_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # Userモデルのnameカラムに対して検索
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followeds, through: :active_relationships, source: :followed
  # フォローされているユーザーを取得
  has_many :followers, through: :passive_relationships, source: :follower

   # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followeds.include?(user)
  end

  # ゲストログインのパスワード、名前の設定
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end  
end
