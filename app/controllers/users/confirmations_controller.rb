# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # skip_before_action :verify_authenticity_token
  # respond_to :json
  
  # GET /resource/confirmation/new
  def new
  end

  # POST /resource/confirmation
   def create
    @user = User.find_by(email: params[:email])
    if @user
      unless @user.confirmed?
        @user.resend_confirmation_instructions
        render json: {
          message: 'We have sent you an email with the confirmation link'
        },
        status: :ok
      else
        render json: {
          message: 'Email was already confirmed.'
        }
      end
    else
      render json: {
        error: 'We have sent you an email with the confirmation link'
      }
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @user = resource_class.confirm_by_token(params[:confirmation_token])

    if @user.errors.empty?
      render json: {
        message: 'Your account has been confirmed. You can now login'
      }, status: :ok
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
