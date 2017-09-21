class NeedsController < ApplicationController

  def by_location
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    locations = YAML.load_file("lib/locations.yml")
    closest = closest_location(lat, lng, locations)
    if closest.present?
      render json: closest
    else
      render json: {}, status: :no_content
    end
  end

  private

  def closest_location(lat, lng, locations)
    closest = nil
    closest_name = nil
    closest_distance = Float::MAX
    locations.each { |neighborhood, location|
      if closest.blank?
        closest = location
        closest_name = neighborhood
      else
        delta = distance(location["lat"].to_f, location["lng"].to_f, lat, lng)
        if delta < closest_distance
          closest = location
          closest_name = neighborhood
          closest_distance = delta
        end
      end
    }
    return { closest_name => closest }
  end

  def distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
  end

end
