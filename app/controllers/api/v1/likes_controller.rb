class Api::V1::LikesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    def index
        @likes = Like.all
        render json:@likes
    end

    def create
        @like = Like.new(like_params)
        if @like.save
            render json:@like, status: 200, message: 'like created successfully'
        else
            render json: { errors:@like.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
        if @like.destroy
            render json: { status: 'Success', message: 'Like deleted sucessfully' }, status: :ok
        else
            render json: { status: 'Failed', message: 'Failed to delete Like' }, status: :bad_request
        end
    end
    
    def like_params
        params.require(:like).permit(:user_id, :post_id)
    end
end
