class GroupMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_group_owner, only: [:new, :create]
  before_action :set_group_and_message, only: [:destroy] 

  def new
    @group = Group.find(params[:group_id])
    @group_message = GroupMessage.new
  end

  def create
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.new(group_message_params)
    @group_message.user_id = current_user.id

    if @group_message.save
      redirect_to group_path(@group), notice: 'お知らせを投稿しました。'
    else
      render :new
    end
  end

  def destroy 
    @group_message.destroy
    redirect_to group_path(@group), notice: 'お知らせを削除しました。'
  end

  private

  def group_message_params
    params.require(:group_message).permit(:title, :body)
  end

  def ensure_group_owner
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: 'グループオーナーのみお知らせを投稿できます。'
    end
  end

  def set_group_and_message 
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to group_path(@group), alert: '権限がありません。'
      end
  end
end