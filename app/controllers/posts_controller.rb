class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: 'Your post was created successfully'
    else
      flash.now[:alert] = @post.errors.full_messages.join('<br>').html_safe
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Your post was edited successfully'
    else
      flash.now[:alert] = @post.errors.full_messages.join('<br>').html_safe
      render :edit
    end
  end

  def show
  end

  def destroy
    @post.delete
    redirect_to posts_path, notice: 'Your post was deleted'
  end

  private

    def post_params
      params.require(:post).permit(:date, :rationale, :status)
    end

    def set_post
      @post = Post.find params[:id]
    end
end
