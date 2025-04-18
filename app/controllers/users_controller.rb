class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  # ユーザー編集画面
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー編集処理
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Book was successfully editingi."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "Book was make a mistake editing."
      render :edit
    end 
  end

  # ユーザー一覧画面
  def index
    # @book = Book.new
    @users = User.page(params[:page])
    @user = current_user
  end

  # ユーザー詳細画面
  def show
    # @book = Book.new
    @user = User.find(params[:id]) 
  end

  private

  # 許可したカラムだけ保存、更新する
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  # ログイン中のユーザーだけが、自分のページを操作できるようにするためのメソッド
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end  
end
