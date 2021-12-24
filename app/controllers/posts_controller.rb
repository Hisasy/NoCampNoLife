class PostsController < ApplicationController
  def index
    @post_5 = Post.last(5)
    @posts = Post.all.order(created_at: :desc)


  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/"
  end

  private

    def post_params
      params.require(:post).permit(:main_title, :date, :location, :sub_title, :body, { images: [] })
    end
end
