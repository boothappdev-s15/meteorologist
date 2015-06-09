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

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_data = JSON.parse(open(url).read)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url = "https://api.forecast.io/forecast/cd377823b40cda8905ec4094688e4b11/" + @latitude.to_s + "," + @longitude.to_s
    parsed_fdata = JSON.parse(open(url).read)

    @current_temperature = parsed_fdata["currently"]["temperature"]

    @current_summary = parsed_fdata["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_fdata["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_fdata["hourly"]["summary"]

    @summary_of_next_several_days = parsed_fdata["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
