module Needs
  def self.find(need)
    yaml = YAML.load_file("lib/needs.yml")
    yaml.select { |x| x == need }

    needs_collections = yaml.select { |x| x.is_a?(Hash) }

    needs_collections.each do |key, value|
      return value if key == need
    end

    if needs_keys.include?(need)
      return needs_collections[need]
    end


    yaml[needs]
  end

  def self.all
    YAML.load_file("lib/needs.yml")
  end
end
