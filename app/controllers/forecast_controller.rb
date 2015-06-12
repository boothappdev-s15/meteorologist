require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.forecast.io/forecast/d65892e0c3c0000eb2a2eea1aad4f7a7/#{@lat},#{@lng}"

    json_data = open(url).read

    ruby_data = JSON.parse(json_data)

    @current_temperature = ruby_data["currently"]["temperature"]

    @current_summary = ruby_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = ruby_data["minutely"]["summary"]

    @summary_of_next_several_hours = ruby_data["hourly"]["summary"]

    @summary_of_next_several_days = ruby_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
