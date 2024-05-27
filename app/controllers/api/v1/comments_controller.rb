class Api::V1::CommentsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    def index
        @comments = Comment.all
        render json:@comments
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render json:@comment, status: '200', message: 'Comment created successfully'
        else
            render json: { errors:@comment.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            render json: { status: 200, message: 'Comment deleted sucessfully' }, status: :ok
        else
            render json: { status: 400, message: 'Failed to delete Comment' }, status: :bad_request
        end
    end
    
    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :text)
    end
end
