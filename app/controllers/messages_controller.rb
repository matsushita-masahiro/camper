class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create,:make]
  
  def make
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(room_id: @room.id, user_id: params[:user_id])
    @message = Message.create(message_params2)
    redirect_to room_url(@room)
  end
  
  def create
    if Entry.where(user_id: current_user.id,room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params1)
      redirect_to room_url(params[:message][:room_id])
    else
      flash[:alert] = "無効なユーザー"
      redirect_to root_url
    end
  end
  
  
  private
  
    def message_params1
      params.require(:message).permit(:body,:user_id,:room_id).merge(user_id: current_user.id)
    end
    
    def message_params2
      params.require(:message).permit(:body,:user_id,:room_id).merge(user_id: current_user.id,room_id: @room.id)
    end
end
