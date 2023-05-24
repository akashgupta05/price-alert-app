class Api::PricesResponse
  attr_reader :code, :body

  def initialize(response)
    @code = response.code
    @body = response.read_body
  end

  def success?
    code == '200'
  end

  def prices_map
    json_body = JSON.parse(@body)
    json_body.map { |item| [item['symbol'].downcase, item['current_price']] }.to_h
  end
end
