class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  		   # 架空モデルfollowings　中間テーブルのrelationshipsを通るように　フォローしているuserの取得
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  		   # 1行目の逆を意味する(逆方向)
  has_many :followers, through: :reverse_of_relationships, source: :user
  		   # 架空モデルfollowers　中間テーブルのreverse_of_relationshipsを通るように　フォロワー(user)の取得
  		   # foregin_key = 入口
		   # source = 出口
  # フォロー機能
  attachment :profile_image # attachment :profile_image, destroy: false?
  validates :name, presence: true, length: {in: 2..20} # 2~20文字以内
  validates :introduction, length: {maximum: 50} # 50文字以内

  def follow(other_user)
    unless self == other_user #フォローしようとしているother_userが自分でないか検証している
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user) #フォローがあればアンフォロー
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship #relationshipが存在すればdestroyする
  end

  def following?(other_user)
    self.followings.include?(other_user)
    # フォローしている User 達を取得。other_user が含まれていればtrue,含まれていなければfalseを返す。
  end

end