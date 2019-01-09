class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:show,:create]
  before_action :correct_referrer
  
  def index
    # 友達のみ（未設定）
    @friend_posts = Post.all
    # 降順
    @new_posts = Post.order("created_at desc")
    # いいねがない場合表示されない
    @hot_posts = Post.joins(:like).group(:id).order("count(posts.id) desc") 
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: @post.id)
    @like = Like.new
    @user = current_user
    @relationship = Relationship.new
    @message = Message.new
    
    room_id = searchRoomId(@post.user_id,current_user.id)
    if room_id == 0
      @room = Room.new
    else
      @room = Room.find(room_id)
    end
    
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

    def correct_referrer
      if request.referer.nil?
        flash[:alert] = "無効なアクセス"
        redirect_to root_url
      end
    end

end
