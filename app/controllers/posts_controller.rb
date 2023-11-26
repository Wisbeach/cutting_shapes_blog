class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :manage, :bulk_delete]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    # Assuming set_post handles this
  end

  def manage
    @posts = Post.all
  end

  def update
    # Assuming set_post handles this

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

  def bulk_delete
    Post.where(id: params[:post_ids]).destroy_all
    redirect_to manage_posts_path, notice: 'Selected posts were successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
    check_authorization unless action_name == 'show'
  end

  def check_authorization
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user == @post.user || current_user.admin?
  end

  def check_admin
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.is_admin?
  end

  def post_params
    params.require(:post).permit(:title, :body, :tags, :featured_image)
  end
end
