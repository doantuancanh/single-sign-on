# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery except: :create
  before_action :configure_sign_up_params, only: [:create]
  before_action :validate_email, only: [:create]
  before_action :validate_client_application, only: %i[create]

  include RespondAction

  def create
    super do
      resource.email = params[:email]
      resource.save
      if params[:role].present?
        resource.add_role params[:role].to_sym 
      else
        resource.add_role :parent
      end
    end
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # def sign_up_params
  #   params[:user] = params
  #   params.require(:user).permit(:email, :username, :password, :password_confirmation)
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #
  private

  def validate_email
    if User.exists?(email: params[:email])
      response = Response::JsonResponse.new(Response::Message.new(400, "Email existed!"), {})
      render json: response.build, status: 400
    end
  end

  def validate_client_application
    client = Doorkeeper::Application.where(uid: params[:client_id]).first()

    if client.blank?
      response = Response::JsonResponse.new(Response::Message.new(400, "Invalid Application!"), {})
      render json: response.build, status: 400
    end
  end
end
