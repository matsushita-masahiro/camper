class WelcomeController < ApplicationController
  
  def index
    if user_signed_in?
      # イベントを取ってくる
      @host_events = Event.where(user_id: current_user.id)
      @events = Event.joins(:event_members).where("event_members.user_id=?", current_user.id)
      # Relationshipモデルからfriendを取ってくる
      @friends = Relationship.where(user_id: current_user.id).or(Relationship.where(friend_id: current_user.id))
      # ルームを取得する
      @rooms = Room.joins(:entries).where('entries.user_id = ?',current_user.id)
    end
  end
end
