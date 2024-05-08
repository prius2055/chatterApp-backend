class Api::V1::PostsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index]
 def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: { status: '200', message: 'Post created successfully' }, status: :created
    else
      render json: { errors:@post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      render json: { status: 'Success', message: 'Post deleted sucessfully' }, status: :ok
    else
      render json: { status: 'Failed', message: 'Failed to delete Post' }, status: :bad_request
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :author_name, :topic, :content)
  end
end
