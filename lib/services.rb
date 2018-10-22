# scraping CSS file of site
require 'webshot'
require 'miro'
require 'json'
require 'nokogiri'
require_relative 'site'
# uses WebShot gem to screencap site
class ScrapeSiteColour
  def initialize(url)
    begin
      @capper = Webshot::Screenshot.instance.capture(url, 'tmp.jpg')
    rescue Webshot::WebshotError
      puts "#{url} failed to load. Skipping colour scrape."
      @capper = nil
    end
    Miro.options[{color_count: 1 }]
  end

  def rgb_colour
    Miro::DominantColors.new('tmp.jpg').to_rgb[0] unless @capper.nil?
  end
end

# scraping a top site website to find top sites of given country
class ScrapeAlexaByCountry
  def initialize(country_code, site_repo)
    @country_code = country_code
    @url = 'top-china.html' #"https://www.alexa.com/topsites/countries/#{@country_code.upcase}"
    @site_repo = site_repo
  end

  def call
    html_doc = Nokogiri::HTML(open(@url).read)
    html_doc.search('.site-listing').each do |element|
      @site_repo.add_site(Site.new(url = element.search('.DescriptionCell p a').text.strip.downcase,
                                   element.search('.number').text.strip.to_i,
                                   @country_code.upcase,
                                   rgb = ScrapeSiteColour.new("http://#{url}").rgb_colour,
                                   GetColourName.from_rgb(rgb)))
    end
  end
end

# gets colour name from thecolorapi.com
class GetColourName
  def self.from_rgb(rgb_array)
    rgb = rgb_array.join(',') unless rgb_array.nil?
    JSON.parse(open("http://www.thecolorapi.com/id?rgb=rgb(#{rgb})").read)['name']['value'] unless rgb_array.nil?
  end
end
