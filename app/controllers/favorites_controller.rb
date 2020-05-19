class FavoritesController < ApplicationController
	def create
		@book = Book.find(params[:book_id]) #:idでなく:book_idの理由は？
		@favorite = current_user.favorites.new(book_id: params[:book_id]) #?? カリキュラム要復習
		@favorite.save
		redirect_back(fallback_location: root_path) #いいねを行う前の画面に戻る
		# redirect_to request.referer でも可？
	end

	def destroy
		@book = Book.find(params[:book_id])
		@favorite = current_user.favorites.find_by(book_id: @book.id) #?? カリキュラム要復習
		@favorite.destroy
		redirect_back(fallback_location: root_path) #いいねを行う前の画面に戻る
		# redirect_to request.referer でも可？
	end
end
