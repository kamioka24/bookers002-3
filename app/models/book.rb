class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user) #各投稿(book)に自分(current_user)のいいね(favorite)がついているか判断する
            favorites.where(user_id: user.id).exists? # exists = 存在
    end

	validates :title, presence: true #空欄
	validates :body, presence: true, length: {maximum: 200} #200文字以内
end