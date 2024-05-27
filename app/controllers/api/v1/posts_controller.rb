class Api::V1::PostsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
    @posts = Post.includes(:user, :comments).all.with_attached_post_image
    render json: @posts.map { |post|
      post.as_json.merge({
        post_image_url: post.post_image.attached? ? url_for(post.post_image) : nil,
        posterDetail: post.user.as_json(only: [:id, :firstname, :lastname, :email]),
        comments:post.comments.map {|comment|
          comment.as_json.merge({
            commenterDetail:comment.user.as_json(only: [:firstname, :lastname, :email])
            })
        },
        likes:post.likes.map {|like|
          like.as_json.merge({
            likeDetail:like.user.as_json(only: [:firstname, :lastname, :email])
            })
        }
      })
    }
  end



  def show
    @post = Post.includes(:user).find(params[:id])
    render json:  @post.as_json.merge({
        post_image_url: @post.post_image.attached? ? url_for(@post.post_image) : nil,
        posterDetail: @post.user.as_json(only: [:id, :firstname, :lastname, :email]),
         comments:@post.comments.map {|comment|
          comment.as_json.merge({
            commenterDetail:comment.user.as_json(only: [:firstname, :lastname, :email])
            })
        },
         likes:@post.likes.map {|like|
          like.as_json.merge({
            likerDetail:like.user.as_json(only: [:firstname, :lastname, :email])
            })
        }
      })
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json:PostSerializer.new(@post).serializable_hash[:data][:attributes], status: '200', message: 'Post created successfully'
     
    else
      render json: { errors:@post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: { status: 200, message: 'Post deleted sucessfully' }, status: :ok
    else
      render json: { status: 400, message: 'Failed to delete Post' }, status: :bad_request
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :topic, :content, :post_image)
  end
end
