module Needs
  def self.find(needs)
    yaml = YAML.load_file("lib/needs.yml")
    yaml[needs]
  end

  def self.all
    YAML.load_file("lib/needs.yml")
  end
end
