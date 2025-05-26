class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  # 新規投稿画面
  def new
    @book = Book.new
  end

  # 投稿処理
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @from = params[:from]
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.page(params[:page])
      flash.now[:alert] = "Book was make a mistake created."
      if @from == "book"
        render 'books/index'
      else 
        @users = User.page(params[:page])
        render 'users/index'
      end  
    end
  end

  # 投稿一覧画面
  def index
    @user = current_user
    @book = Book.new

    case params[:sort]
    when 'created_at DESC'
      books = Book.order(created_at: :desc)
    when 'star DESC'
      books = Book.order(star: :desc)
    else
      to = Time.current.at_end_of_day
      from = (to - 6.days).at_beginning_of_day
      books = Book.all.sort_by { |book| -book.favorites.where(created_at: from...to).count }
      @books = Kaminari.paginate_array(books).page(params[:page])
      return
    end

    @books = books.page(params[:page])
  end
  
  # 投稿詳細画面
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @current_user  = current_user
    if user_signed_in?
      unless ViewCount.exists?(user_id: current_user.id, book_id: @book.id)
        ViewCount.create(user_id: current_user.id, book_id: @book.id)
      end
    end
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

  # 削除処理
  def destroy
    book = Book.find(params[:id])  
    book.destroy 
    redirect_to '/books' 
  end

  private

  # フォームから送信されるparamsのうち、モデルに渡してよい属性だけを許可する
  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  # ログイン中のユーザーが、その本の投稿者と一致しているかどうかをチェックする
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

end
