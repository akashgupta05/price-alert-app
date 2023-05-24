class BinanceClient
  attr_reader :symbol, :request_payload

  BASE_URL = 'wss://stream.binance.com:9443/ws'.freeze

  def initialize(symbol)
    @symbol = symbol
    # @request_payload = {
    #   "id": SecureRandom.uuid,
    #   "method": "ticker.24hr",
    #   "params": {
    #     "symbol": symbol
    #   }
    # }
    @websocket_url = format(BASE_URL, symbol:)
  end

  def connect
    ws = WebSocket::Client::Simple.connect(@websocket_url)
    # ws.send(request_payload.to_json)
    setup_event_handler(ws, symbol)
  end

  private

  def setup_event_handler(ws, symbol)
    ws.on :open do
      request_payload = {
        "id": 1,
        "method": 'SUBSCRIBE',
        "params": ["#{symbol}@ticker"]
      }
      # Rails.logger.info('WebSocket connection established for url', request_payload: request_payload)
      ws.send(request_payload.to_json)
    end

    ws.on :message do |message|
      Rails.logger.info("Received message: #{message.type}")
      if message.type == :ping
        Rails.logger.info("Received ping: #{message.data}")
        ws.send({ 'pong' => message.data }.to_json)
      elsif message.type == :pong
        Rails.logger.info("Received Pong: #{message.data}")
      else
        binding.pry
        request_payload = {
          "id": 1,
          "method": 'ticker.24hr',
          "params": {
            "symbol": symbol
          }
        }
        ws.send(request_payload.to_json)
        # data = JSON.parse(message.data)
        # Rails.logger.info('WebSocket message received for url', message_data: message.data)
      end
      # callback(symbol, data['c'])
    end

    ws.on :close do |e|
      binding.pry
      Rails.logger.info('WebSocket close message received for symbol', e)
    end

    ws.on :error do |e|
      binding.pry
      Rails.logger.info('WebSocket error message received for symbol', error: e.message)
    end
  end

  def handle_ping(ws, ping)
    ws.send({ 'pong' => ping }.to_json)
  end

  def handle_pong(pong)
    Rails.logger.info("Received Pong: #{pong}")
  end
end
