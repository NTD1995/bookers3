class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  # 検索処理
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == "user"
      @users = User.search_for(@content, @method).page(params[:page]).per(1)
    else
      @books = Book.search_for(@content, @method).page(params[:page]).per(1)
    end
  end
end
