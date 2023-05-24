class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.new(user_params)
    user.save
    render json: {
      success: true,
      data: user.to_h
    }, status: :created
  rescue StandardError => e
    render json: {
      success: true,
      error: e.message
    }, status: :bad_request
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password_digest)
  end
end
