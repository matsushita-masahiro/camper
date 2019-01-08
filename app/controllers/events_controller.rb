class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:create,:edit,:show,:update]
  
  def index
    @event = Event.new
    @events = Event.search(params[:search])
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
    @event_member = EventMember.new
    @user = current_user
    @pre_members = EventMember.where(event_id: @event.id,status: 0)
    @fixed_members = EventMember.where(event_id: @event.id,status: 1)
    @relationship = Relationship.new
    @message = Message.new
    @room = enterRoom(@event.user_id,current_user.id)
  end
  
  def edit
    @event = Event.find(params[:id])
    @user = current_user
    @pre_members = EventMember.where(event_id: @event.id,status: 0)
    @fixed_members = EventMember.where(event_id: @event.id,status: 1)
    @relationship = Relationship.new
    @message = Message.new
    @room = enterRoom(@event.user_id,current_user.id)
  end
  
  def update
    
    if Event.find(params[:id]).update(event_params)
      flash[:notice] = "イベント情報を更新しました"
      redirect_to event_url(params[:id])
    else
      flash[:alert] = "更新に失敗しました"
      redirect_to edit_event_url(params[:id])
    end
  end
  
  private
    
    def event_params
      params.require(:event).permit(:title,{files:[]},:body,:place,:recruit_num,:event_date,:deadline).merge( user_id: current_user.id )
    end
    
end
