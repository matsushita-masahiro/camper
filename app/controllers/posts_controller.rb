class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:index,:show,:create]
  before_action :correct_referrer
  
  def index
    # 友達のみ
    @friend_posts = Post.joins('INNER JOIN relationships on posts.user_id = relationships.user_id OR posts.user_id = relationships.friend_id').where('relationships.status = ? AND posts.user_id != ? AND (relationships.user_id=? OR relationships.friend_id=?)', 1, current_user.id,current_user.id,current_user.id).order('created_at desc').paginate(page: params[:page], per_page: 10)
    # 降順
    @new_posts = Post.order("created_at desc").paginate(page: params[:page], per_page: 10)
    # いいねがない場合表示されない
    @hot_posts = Post.joins(:like).group(:id).order("count(posts.id) desc").paginate(page: params[:page], per_page: 10)
    @post = Post.new
    
    if params[:tab].eql? 'friend'
      @friend_list = 'active'
      @friend_tab = 'active in'
    elsif params[:tab].eql? 'new'
      @new_list = 'active'
      @new_tab = 'active in'
    elsif params[:tab].eql? 'hot'
      @hot_list = 'active'
      @hot_tab = 'active in'
    else
      @friend_list = 'active'
      @friend_tab = 'active in'
    end
    
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
