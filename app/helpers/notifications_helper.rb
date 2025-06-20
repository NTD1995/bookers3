module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Book"
      "フォローしている#{notification.notifiable.user.name}さんが\n#{notification.notifiable.title}を投稿しました"
    else
      "投稿した#{notification.notifiable.book.title}が\n#{notification.notifiable.user.name}さんにいいねされました"
    end
  end  
end
