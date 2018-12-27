class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:show,:create]
  
  def index
    @posts = Post.all
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: @post.id)
    @like = Like.new
    @user = current_user
    @relationship = Relationship.new
    @relation_flg = Relationship.where(user_id: current_user.id, friend_id: @post.user_id).empty?
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:notice] = "投稿に成功しました"
    else
      flash[:alert] = "投稿に失敗しました"
    end
    
    redirect_to posts_url
  end
  
  private
    
    def post_params
      params.require(:post).permit(:body,{files:[]})
    end
end
