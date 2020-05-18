class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_book, only:[:edit, :update]

  def create
    @book = Book.new(book_params) #新規投稿保存
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book), notice: "You have creatad book successfully."
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render "index"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new #コメント投稿
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book), notice: "You have updated book successfully."
    else
       render "edit"
    end
  end

  def destroy
  	@book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def current_book
    book = Book.find(params[:id])
    if current_user != book.user
       redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end