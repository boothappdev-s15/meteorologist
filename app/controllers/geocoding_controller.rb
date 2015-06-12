require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    target_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    raw_data = open(target_url).read
    data_hash = JSON.parse(raw_data)


    @latitude = data_hash["results"][0]["geometry"]["location"]["lat"]

    @longitude = data_hash["results"][0]["geometry"]["location"]["lng"]

    render("street_to_coords.html.erb")
  end
end
