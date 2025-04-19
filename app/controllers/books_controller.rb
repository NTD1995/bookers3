class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
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

  # 投稿一覧画面
  def index
    @user = User.find(current_user.id)
    @books = Book.page(params[:page])
    @book = Book.new
  end
  
  # 投稿詳細画面
  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  # 投稿編集画面
  def edit
    @book = Book.find(params[:id])
  end

  # 編集処理
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully editingi."
      redirect_to book_path(@book.id)  
    else
      flash.now[:alert] = "Book was make a mistake editing."
      render :edit
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
