class BookCommentsController < ApplicationController
	before_action :df_comment, only:[:destroy]

	def create
		@book = Book.find(params[:book_id]) # book = Book.find(params[:id]) ではだめな理由
		@book_comment = current_user.book_comments.new(book_comment_params)
		@book_comment.book_id = book.id
		@book_comment.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.find(params[:id])
		@book_comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def df_comment
		book_comment = BookComment.find(params[:id])
	    if current_user != book_comment.user
	       redirect_to books_path
	    end
	end

	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end

end