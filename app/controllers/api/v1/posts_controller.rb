class Api::V1::PostsController < ApplicationController

 def index
    @posts = Property.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: { status: 'Success', message: 'Post created successfully' }, status: :created
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
    params.require(:property).permit(:topic, :content)
  end
end
