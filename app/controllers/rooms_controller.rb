class RoomsController < ApplicationController
  before_action :authenticate_user!, :only => [:show]
  
  def show
    @room = Room.find(params[:id])
    @entries = Entry.where(room_id: @room.id)
    @messages = Message.where(room_id: @room.id)
    @message = Message.new
  end
  
end
