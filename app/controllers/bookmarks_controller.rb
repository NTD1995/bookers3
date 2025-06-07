class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    current_user.bookmarks.create(book: book)
    redirect_back fallback_location: root_path
  end

  def destroy
    book = Book.find(params[:book_id])
    bookmark = current_user.bookmarks.find_by(book: book)
    bookmark&.destroy
    redirect_back fallback_location: root_path
  end
end
