# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery except: :create
  before_action :configure_sign_up_params, only: [:create]
  before_action :validate_client_application, only: %i[create]

  include RespondAction

  def create
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def sign_up_params
    params[:user] = params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  private

  def validate_client_application
    client = Doorkeeper::Application.where(uid: params[:client_id]).first()

    if client.blank?
      response = Response::JsonResponse.new(Response::Message.new(400, "Invalid Application!"), {})
      render json: response.build, status: 400
    end
  end
end
