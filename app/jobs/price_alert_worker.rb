class PriceAlertWorker
  include Sidekiq::Worker

  queue_as :price_alert_queue

  def perform
    Rails.logger.info('PriceAlertWorker started')
    alerts = Alert.where(status: 'created')
    resp = CoinGeckoClient.new.prices
    Rails.logger.error('Error while fetching the prices', error: resp.code) && return unless resp.success?

    prices_map = resp.prices_map
    alerts.each do |alert|
      process(alert, prices_map)
    end
    Rails.logger.info('PriceAlertWorker finished')
  rescue StandardError => e
    Rails.logger.error('Failed to perform price alert job', error: e)
  end

  private

  def process(alert, prices_map)
    alert.trigger! if alert.target_price == prices_map[alert.symbol.downcase]
  end
end
