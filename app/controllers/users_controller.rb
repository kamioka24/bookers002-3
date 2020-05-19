class UsersController < ApplicationController
  before_action :authenticate_user! #devise側が用意したもの
  before_action :error, only:[:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new #新規投稿 保存はbookコントローラ
    @books = @user.books
  end

  def index
    @user = User.find(current_user.id) #or current_user
    @users = User.all
    @book = Book.new #新規投稿 保存はbookコントローラ
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
    #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def error
    user = User.find(params[:id])
    if current_user.id != user.id
       redirect_to user_path(current_user)
    end
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
