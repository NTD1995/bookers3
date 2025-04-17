class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

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

  def index
    # @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    # @book = Book.new
    @user = User.find(params[:id]) 
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end  
end
