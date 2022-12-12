# frozen_string_literal: true

class Api::V1::Users::PasswordsController < Devise::PasswordsController
  protect_from_forgery except: :create
  respond_to :json
  #before_action :forgot_password_params, only: %[create]

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  private
  
  def forgot_password_params
    params[:user] = params[:password]
    params.require(:user).permit!
  end

  #def respond_with(response)
  #end
end
