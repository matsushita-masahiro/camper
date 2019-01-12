class LikesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  before_action :correct_referrer
  
  def create
    @like = Like.new(user_id: current_user.id,post_id: params[:post_id])
    
    if @like.save
      flash[:notice] = "いいねしました"
    else
      flash[:alert] = "いいねに失敗しました"
    end
    
    redirect_back(fallback_location: root_path)
    
  end 
  
  private
  
    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end

end
