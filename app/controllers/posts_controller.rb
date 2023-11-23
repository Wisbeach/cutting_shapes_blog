class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = current_user.posts.create(post_params)
    # @categories = Category.all

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
    # @categories = Category.all
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,  :tags, :featured_image,)
  end
end
