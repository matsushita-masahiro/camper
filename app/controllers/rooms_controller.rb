class RoomsController < ApplicationController
  before_action :authenticate_user!, :only => [:show]
  before_action :correct_referrer
  
  
  def show
    @room = Room.find(params[:id])
    @entries = Entry.where(room_id: @room.id)
    @messages = Message.where(room_id: @room.id)
    @message = Message.new
  end
  
  private

    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end
  
end
