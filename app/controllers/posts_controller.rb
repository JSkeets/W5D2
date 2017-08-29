class PostsController < ApplicationController

  before_action :require_login
  def new
    @subs = Sub.all
    @post = Post.new

  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
  end

  def delete
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def create

    @post = Post.new(post_params)



    @post.author_id = current_user.id

    if @post.save

      redirect_to subs_url
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title,:url,:content,:author_id,sub_ids:[])
  end
end
