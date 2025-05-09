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
  end

  # ユーザー詳細画面
 def show
  @user = User.find(params[:id])
  @book = Book.new
  @currentUserEntry = Entry.where(user_id: current_user.id)
  @userEntry = Entry.where(user_id: @user.id)
  
  unless @user.id == current_user.id
    @isRoom = false
    if @currentUserEntry.any? && @userEntry.any?
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
            break
          end
        end
        break if @isRoom
      end
    end


        Rails.logger.debug("isRoom: #{@isRoom}")
    Rails.logger.debug("roomId: #{@roomId}")
    
    unless @isRoom
      @room = Room.new
      @entry = Entry.new
    end
  end
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
