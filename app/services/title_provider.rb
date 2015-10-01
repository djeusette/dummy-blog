class TitleProvider
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get_title
    response = http_request { RestClient.get "#{url}/words" }
    json = MultiJson.load(response, symbolize_keys: true)
    json[:words]
  end

  private

  def http_request(&block)
    block.call
  rescue RestClient::RequestTimeout, RestClient::ExceptionWithResponse, RestClient::RequestFailed
    { success: false }.to_json
  end
end
