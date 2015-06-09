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

    url = "https://api.forecast.io/forecast/738aa4e801ce4b5ec6fa7b64795dbb96/#{@lat},#{@lng}"
    #raise url.inspect
    #raise open(url).read.inspect
    parsed_data = JSON.parse(open(url).read)
    # raise parsed_data.keys.inspect
    current_temperature = parsed_data["currently"]["temperature"]
    #raise current_temperature.inspect


    @current_temperature = current_temperature

    current_summary = parsed_data["currently"]["summary"]

    @current_summary = current_summary

    summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_hours = several_hours

    several_days = parsed_data["daily"]["summary"]

    @summary_of_next_several_days = several_days

    render("coords_to_weather.html.erb")
  end
end
