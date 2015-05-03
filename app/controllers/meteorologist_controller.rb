require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_street_address}"
    #raise url.inspect

    parsed_data = JSON.parse(open(url).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/4dfa7124a09b5ddec6544ce5f0e50112/#{@lat},#{@lng}"

    parsed_weather = JSON.parse(open(weather_url).read)
    @current_temperature = parsed_weather["currently"]["temperature"]

    @current_summary = parsed_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
