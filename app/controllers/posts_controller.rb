class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:show,:create]
  
  def index
    @posts = Post.all
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      flash[:notice] = "投稿に成功しました"
    else
      flash[:alert] = "投稿に失敗しました"
    end
    
    redirect_to posts_url
  end
  
  private
    
    def post_params
      params.require(:post).permit(:body,{files:[]},:user_id)
    end
end
