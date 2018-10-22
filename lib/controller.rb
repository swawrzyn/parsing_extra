# controller file
require_relative 'site_repository'
require_relative 'services'
class Controller
  def initialize(repo)
    @repo = repo
  end

  def scrape_by_country(country_code)
    ScrapeAlexaByCountry.new(country_code, @repo).call
  end

end
