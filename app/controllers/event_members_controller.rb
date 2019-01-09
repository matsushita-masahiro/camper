class EventMembersController < ApplicationController
  before_action :authenticate_user!, :only => [:create,:change]
  before_action :correct_referrer
  
  def create
    
    if @event_member = EventMember.create(event_member_params)
      flash[:notice] = "参加しました"
    else
      flash[:alert] = "参加に失敗しました"
    end
    
    redirect_to event_url(params[:event_member][:event_id])
    
  end
  
  def change
    ids = params[:user_id]
    
    ids.each do |user_id|
      member = EventMember.find_by(event_id: params[:event_id], user_id: user_id)
      
      if member.status == 0
        member.update_attribute(:status, 1)
      elsif member.status == 1
        member.update_attribute(:status, 0)
      end
    end
    
    redirect_to event_url(params[:event_id])
  end
  
  
  private
    
    def event_member_params
      params.require(:event_member).permit(:event_id,:user_id).merge(user_id: current_user.id)
    end
    
    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end
    
end
