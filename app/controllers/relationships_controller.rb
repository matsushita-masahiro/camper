class RelationshipsController < ApplicationController
  before_action :authenticate_user!, :only => [:create,:update]
  before_action :correct_referrer
  
  def create
    @relationship = current_user.relationships.create(friend_id: params[:friend_id])
    
    if @relationship.save
      flash[:notice] = "友達申請しました"
    else
      flash[:alert] = "友達申請に失敗しました"
    end
    
    redirect_back(fallback_location: root_path)
  end
  
  def update
    @relationship = Relationship.find(params[:id])
    
    if @relationship.update_attribute(:status,1)
      flash[:notice] = '承認しました'
    else
      flash[:alert] = '承認に失敗しました'
    end
    
    redirect_to root_url
  end
  
  private
  
    def relationship_params
      params.require(:relationship).permit(:friend_id,:status)
    end

    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end

end
