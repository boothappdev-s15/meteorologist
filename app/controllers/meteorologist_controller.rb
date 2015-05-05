require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
end

def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    # Get latitude and longitude from google maps api
    parsed_gdata = JSON.parse(open("https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address).read)
    @lat = parsed_gdata["results"][0]["geometry"]["location"]["lat"].to_s
    @lng = parsed_gdata["results"][0]["geometry"]["location"]["lng"].to_s

    @api_key = "800605e0f97f882cb440fe4e12e7ed70"

    url = "https://api.forecast.io/forecast/" + @api_key + "/" + @lat + "," + @lng

    parsed_fdata = JSON.parse(open(url).read)

    @current_temperature = parsed_fdata["currently"]["temperature"]

    @current_summary = parsed_fdata["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_fdata["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_fdata["hourly"]["summary"]

    @summary_of_next_several_days = parsed_fdata["daily"]["summary"]

    render("street_to_weather.html.erb")
end
end
