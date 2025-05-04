class RelationshipsController < ApplicationController

  # ユーザーがフォローする
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  # ユーザーがフォローを解除する
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
   
  # フォロワー一覧画面
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page])
  end
  
  # フォロー一覧画面
  def followeds
    user = User.find(params[:user_id])
    @users = user.followeds.page(params[:page])
  end  

end
