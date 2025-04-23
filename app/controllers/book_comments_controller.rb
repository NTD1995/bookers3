class BookCommentsController < ApplicationController
  # コメント作成処理
  def create
    book_comment = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book_comment.id
    comment.save
    redirect_to book_path(book_comment)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end  
  
end
