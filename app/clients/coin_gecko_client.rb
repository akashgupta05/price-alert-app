require 'net/http'

class CoinGeckoClient
  PATH = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=market_cap_desc&per_page=100&page=1&sparkline=false'

  def initialize
    url = URI(PATH)
    @https = Net::HTTP.new(url.host, url.port)
    @https.use_ssl = true

    @request = Net::HTTP::Get.new(url)
  end

  def prices
    response = @https.request(@request)
    Api::PricesResponse.new(response)
  end
end
