class UsersController < ApplicationController
  before_action :authenticate_user! #devise側が用意したもの
  before_action :error, only:[:edit, :update]
  #上2つのアクションはそれぞれのアクションを行う前にerrorアクションを行う。
  #よって今回は@user = User.find(params[:id])を2つのアクション内に書く必要がなくなる。

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

  def follows
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private
    #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def error
    @user = User.find(params[:id])
    if current_user.id != @user.id
       redirect_to user_path(current_user)
    end
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
