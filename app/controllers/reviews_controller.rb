class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: [:destroy]

  # レビュー投稿
  def create
    @review = @book.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @book, notice: "レビューを投稿しました。"
    else
      flash.now[:alert] = "レビューの投稿に失敗しました。"
      render 'books/show'
    end
  end

  # レビュー一覧（必要な場合）
  def index
    @reviews = @book.reviews.includes(:user).order(created_at: :desc)
  end

  # レビュー削除
  def destroy
    if @review.user == current_user
      @review.destroy
      redirect_to @book, notice: "レビューを削除しました。"
    else
      redirect_to @book, alert: "他人のレビューは削除できません。"
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end  
end
