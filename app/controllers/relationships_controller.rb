class RelationshipsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  
  def create
    @relationship = current_user.relationships.create(friend_id: params[:friend_id])
    
    if @relationship.save
      flash[:notice] = "友達申請しました"
    else
      flash[:alert] = "友達申請に失敗しました"
    end
    
    redirect_to posts_url
  end
  
  private
  
    def relationship_params
      params.require(:relationship).permit(:friend_id,:status)
    end
end
