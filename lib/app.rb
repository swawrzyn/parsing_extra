require_relative 'controller'
require_relative 'site'
require_relative 'site_repository'

json_file = File.join(__dir__, 'sites.json')

site_repo = SiteRepository.new(json_file)

Controller.new(site_repo).scrape_by_country('CN')
