class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :book

	#ひとりが１つの投稿に対して１つしかいいねを付けられないようにする
	validates_uniqueness_of :book_id, scope: :user_id
end
