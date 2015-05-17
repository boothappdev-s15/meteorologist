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

    full_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    parsed_data = JSON.parse(open(full_url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_f

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_f

    forecast_url = "https://api.forecast.io/forecast/64998bd1d4cacd94578213eae14f43de/#{@latitude},#{@longitude}"
    forecast_parsed_data = JSON.parse(open(forecast_url).read)

    @current_temperature = forecast_parsed_data["currently"]["temperature"]

    @current_summary = forecast_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = forecast_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = forecast_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = forecast_parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
