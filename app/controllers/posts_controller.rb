class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :check_authorization, only: [:new, :create, :edit, :update, :destroy]


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) # To allow viewing by any user
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)
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
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def check_authorization
    unless current_user.is_admin?
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :tags, :featured_image)
  end
end
