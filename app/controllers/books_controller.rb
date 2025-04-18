class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def update
  end

  # 新規投稿画面
  def new
    @book = Book.new
  end

  # 投稿処理
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to book_path(@book.id)
      else
        @user = User.find(current_user.id)
        @books = Book.page(params[:page])
          flash.now[:alert] = "Book was make a mistake created."
          render :index
      end
  end
  
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

end
