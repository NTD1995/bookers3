class ReadingLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reading_log, only: [:edit, :update, :destroy]

  def index
    @reading_logs = current_user.reading_logs.includes(:book)

    respond_to do |format|
      format.html
      format.json {
        render json: @reading_logs.map { |log|
          {
            id: log.id,
            title: log.book.title,
            start: log.read_on,
            url: reading_log_path(log)
          }
        }
      }
    end
  end  

  def new
    @reading_log = current_user.reading_logs.new
  end

  def create
    @reading_log = current_user.reading_logs.new(reading_log_params)
    if @reading_log.save
      redirect_to reading_logs_path, notice: '読書記録を追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reading_log.update(reading_log_params)
      redirect_to reading_logs_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @reading_log.destroy
    redirect_to reading_logs_path, notice: '削除しました'
  end

  private

  def set_reading_log
    @reading_log = current_user.reading_logs.find(params[:id])
  end

  def reading_log_params
    params.require(:reading_log).permit(:book_id, :read_on)
  end

end
