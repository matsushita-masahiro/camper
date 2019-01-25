class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:create,:edit,:show,:update,:replace]
  before_action :correct_referrer
  
  def index
    @event = Event.new
    @events = Event.search(params[:search]).paginate(page: params[:page], per_page: 10)
  end
  
  def create
    
    @event = Event.new(event_params)
    
    if @event.save
      flash[:notice] = "イベントを作成しました"
    else
      flash[:alert] = "イベント作成に失敗しました"
    end
    
    redirect_to events_url
    
  end
  
  def show
    @event = Event.find(params[:id])
    @event_member = EventMember.new
    @pre_users = User.joins(:event_members).where('event_members.event_id=? AND event_members.status=?',@event.id,0)
    @users = User.joins(:event_members).where('event_members.event_id=? AND event_members.status=?',@event.id,1)
    @relationship = Relationship.new
    @message = Message.new
    @room = enterRoom(@event.user_id,current_user.id)
  end
  
  def edit
    @event = Event.find(params[:id])
    @user = current_user
    @pre_users = User.joins(:event_members).where('event_members.event_id=? AND event_members.status=?',@event.id,0)
    @users = User.joins(:event_members).where('event_members.event_id=? AND event_members.status=?',@event.id,1)
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
  
  def replace
    @event = Event.find(params[:id])
    # 選択されたファイルを削除
    remove_file_at_index(params[:file_id].to_i)
    
    unless @event.save
      flash[:alert] = '変更に失敗しました' 
      redirect_back(fallback_location: root_path)
    end
    
    # ファイルの追加
    add_file(params[:event][:files],params[:file_id].to_i)
    
    unless @event.save
      flash[:alert] = '変更に失敗しました' 
      redirect_back(fallback_location: root_path)
    end
    
    flash[:notice] = '画像を変更しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
    
    def event_params
      params.require(:event).permit(:title,{files:[]},:body,:place,:recruit_num,:event_date,:deadline).merge( user_id: current_user.id )
    end
    
    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end
    
    def add_file(new_files,index)
      files = @event.files
      files.insert(index,new_files) 
      @event.files = files
    end

    def remove_file_at_index(index)
      remain_files = @event.files # copy the array
      deleted_file = remain_files.delete_at(index) # delete the target file
      deleted_file.try(:remove!) # delete file from S3
      @event.files = remain_files # assign back
    end
      
end
