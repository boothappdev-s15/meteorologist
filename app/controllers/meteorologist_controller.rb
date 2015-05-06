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


    # ryan's comments:
        # first, use what you did in street_to_coords
        # then, use those lat and lng values from street_to_coords to pull forecast

        url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

        json_data = open(url).read

        ruby_data = JSON.parse(json_data)

        results = ruby_data["results"]

        @lat = results[0]["geometry"]["location"]["lat"]

        @lng = results[0]["geometry"]["location"]["lng"]

        urls = "https://api.forecast.io/forecast/d65892e0c3c0000eb2a2eea1aad4f7a7/#{@lat},#{@lng}"

        json_data = open(urls).read

        met_data = JSON.parse(json_data)

        @current_temperature = met_data["currently"]["temperature"]

        @current_summary = met_data["currently"]["summary"]

        @summary_of_next_sixty_minutes = met_data["minutely"]["summary"]

        @summary_of_next_several_hours = met_data["hourly"]["summary"]

        @summary_of_next_several_days = met_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
