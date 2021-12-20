class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).reverse_order

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to "/"
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
    @post = Post.update(post_params)
    redirect_to post_path
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
