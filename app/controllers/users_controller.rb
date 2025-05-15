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
      flash[:notice] = "Book was successfully editing."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "Book was make a mistake editing."
      render :edit
    end 
  end

  # ユーザー一覧画面
  def index
    @users = User.page(params[:page])
    @user = current_user
    @book = Book.new
    @currentUserEntry = Entry.where(user_id: current_user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu| 
        @userEntry.each do |u| 
          if cu.room_id == u.room_id 
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end 
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
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
