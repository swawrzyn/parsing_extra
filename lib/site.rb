# storing site color information
class Site
  attr_reader :url, :data
  def initialize(params = {})
    @url = url
    @data = { url: params['url'], ranking: params['ranking'], country: params['country'], colour: params['colour'],
             colour_name: params['colour_name'] }
  end
end
