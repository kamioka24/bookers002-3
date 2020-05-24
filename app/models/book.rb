class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user) #各投稿(book)に自分(current_user)のいいね(favorite)がついているか判断する
            favorites.where(user_id: user.id).exists? # exists = 存在
    end

	validates :title, presence: true #空欄
	validates :body, presence: true, length: {maximum: 200} #200文字以内

	  # 検索機能・Userが選択されて、各項目選択時の処理
  	def Book.search(search, user_or_book, how_search)
	  if user_or_book == "2"
	    if how_search == "1"
	       Book.where(['title LIKE ?', "#{search}"])
	    elsif how_search == "2"
	       Book.where(['title LIKE ?', "#{search}%"])
	    elsif how_search == "3"
	       Book.where(['title LIKE ?', "%#{search}"])
	    elsif how_search == "4"
	       Book.where(['title LIKE ?', "%#{search}%"])
	    else
	       Book.all
	    end
	  end
	end
end
