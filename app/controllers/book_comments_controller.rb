class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id]) # book = Book.find(params[:id]) ではだめ
		@book_comment = current_user.book_comments.new(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		@user = @book.user
		if @book_comment.save
		   redirect_back(fallback_location: root_path) #コメント前の画面に戻る
		else
		   render '/books/show'
		end
	end

	def destroy
		@book = Book.find(params[:book_id])
		book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
		redirect_back(fallback_location: root_path) #コメント前の画面に戻る
	end

	private

	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end

end