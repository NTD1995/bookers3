class ReadingStatusesController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!

  def create
    @reading_status = current_user.reading_statuses.find_or_initialize_by(book: @book)
    @reading_status.status = params[:status]
    if @reading_status.save
      redirect_to @book, notice: '読書ステータスを登録しました'
    else
      redirect_to @book, alert: '登録に失敗しました'
    end
  end

  def update
    @reading_status = current_user.reading_statuses.find_by(book: @book)
    if @reading_status.update(status: params[:status])
      redirect_to @book, notice: 'ステータスを更新しました'
    else
      redirect_to @book, alert: '更新に失敗しました'
    end
  end

  def destroy
    @reading_status = current_user.reading_statuses.find_by(book: @book)
    @reading_status&.destroy
    redirect_to @book, notice: 'ステータスを削除しました'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end  
end
