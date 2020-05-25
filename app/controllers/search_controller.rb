class SearchController < ApplicationController
	def search
		@user_or_book = params[:option]
		@how_search = params[:choice]
		@word = params[:search] #searchした言葉をViewに呼び出すための定義
		if @user_or_book == "1"
		   @users = User.search(params[:search], @user_or_book, @how_search)
		else
		   @books = Book.search(params[:search], @user_or_book, @how_search)
		end
	end
end
