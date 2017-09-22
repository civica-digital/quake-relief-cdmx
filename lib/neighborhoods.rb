module Neighborhoods
  def self.find(neighborhood)
    yaml = YAML.load_file("lib/neighborhoods.yml")
    yaml[neighborhood]
  end

  def self.all
    YAML.load_file("lib/neighborhoods.yml")
  end

  def self.all_keys
    yaml = YAML.load_file("lib/neighborhoods.yml")
    yaml.map(&:keys).flatten.map(&:titleize)
  end
end
