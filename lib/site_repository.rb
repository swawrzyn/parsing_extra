require 'json'
# storing all the parsed sites
class SiteRepository
  def initialize(json_file)
    @json_file = json_file
    @repo = {}
    @new_json = File.read(@json_file)
    load_from_json
  end

  def all
    @repo
  end

  def add_site(site)
    @repo[site.url] = site.data
    save_to_json
  end

  def del_site(index)
    @repo.delete_at(index)
  end

  def save_to_json
    File.open(@json_file, 'wb') do |file|
      file.write(JSON.generate(@repo))
    end
  end

  private

  def load_from_json
    json_output = JSON.parse(@new_json)
    json_output.each { |k, v| @repo[k.to_s] = Site.new(v) }
  end
end
