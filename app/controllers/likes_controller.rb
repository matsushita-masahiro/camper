class LikesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  before_action :correct_referrer
  
  def create
    @like = Like.new(user_id: current_user.id,post_id: params[:post_id])
    
    if @like.save
      flash[:notice] = "いいねに成功しました"
    else
      flash[:alert] = "いいねに失敗しました"
    end
    
    redirect_to post_url(params[:post_id])
    
  end 
  
  private
  
    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end

end
