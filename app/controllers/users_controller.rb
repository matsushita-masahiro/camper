class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:update,:index,:show]
  
  def index
    @users = User.search(params[:search])
    @relationship = Relationship.new
    @message = Message.new
  end
  
  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
    @message = Message.new
    @room = enterRoom(current_user.id,@user.id)
    @posts = Post.where(user_id: @user.id)
  end
   
  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
    else
      flash[:alert] = "更新に失敗しました"
    end
    
    redirect_to posts_path
  end
  
  private
    
    def user_params
      params.require(:user).permit(:image,:name,:intro)
    end
  
end