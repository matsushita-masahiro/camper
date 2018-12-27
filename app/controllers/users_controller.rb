class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:update]
   
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
