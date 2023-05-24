class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    if token
      decoded_token = JsonWebToken.decode(token)
      @current_user = User.find(decoded_token[:user_id]) if decoded_token
    end

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  attr_reader :current_user
end
