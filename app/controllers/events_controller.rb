class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:create]
  
  def index
    @event = Event.new
    @events = Event.all
  end
  
  def create
    
    if @event = Event.create(event_params)
      flash[:notice] = "イベントを作成しました"
    else
      flash[:alert] = "イベント作成に失敗しました"
    end
    
    redirect_to events_url
    
  end
  
  def show
    @event = Event.find(params[:id])
    @user = current_user
    @members = @event.event_members.all
    @relationship = Relationship.new
    @message = Message.new
    
    room_id = searchRoomId(@event.user_id,current_user.id)
    if room_id == 0
      @room = Room.new
    else
      @room = Room.find(room_id)
    end

  end
  
  private
    
    def event_params
      params.require(:event).permit(:title,{files:[]},:body,:place,:recruit_num,:event_date,:deadline).merge( user_id: current_user.id )
    end
end
