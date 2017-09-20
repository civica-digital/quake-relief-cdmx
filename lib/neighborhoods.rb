module Neighborhoods
  def self.find(neighborhood)
    yaml = YAML.load_file("lib/neighborhoods.yml")
    yaml[neighborhood]
  end
end
