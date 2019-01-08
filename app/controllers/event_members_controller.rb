class EventMembersController < ApplicationController
  before_action :authenticate_user!, :only => [:create,:update]
  
  def create
    
    if @event_member = EventMember.create(event_member_params)
      flash[:notice] = "参加しました"
    else
      flash[:alert] = "参加に失敗しました"
    end
    
    redirect_to event_url(params[:event_member][:event_id])
    
  end
  
  def update
  end
  
  private
    
    def event_member_params
      params.require(:event_member).permit(:event_id,:user_id).merge(user_id: current_user.id)
    end
end
