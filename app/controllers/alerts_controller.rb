class AlertsController < ApplicationController
  before_action :set_user_alert, only: [:delete]

  def create
    alert = Alert.new(alert_params)
    alert.user = current_user
    alert.status = 'created'

    if alert.save
      render json: alert, status: :created
    else
      render json: alert.errors, status: :unprocessable_entity
    end
  end

  def delete
    @alert.update(status: 'deleted')
    render json: {
      success: true
    }, status: :ok
  rescue StandardError => e
    render json: {
      success: false
    }, status: :bad_request
  end

  def index
    alerts = current_user.alerts
    alerts = alerts.where(status: params[:status]) if params[:status].present?
    alerts = alerts.paginate(page: params[:page], per_page: params.fetch(:per_page, 10))

    render json: alerts, status: :ok
  end

  private

  def alert_params
    params.require(:alert).permit(:target_price, :symbol)
  end

  def set_user_alert
    @alert = current_user.alerts.find(params[:id])
  end
end
