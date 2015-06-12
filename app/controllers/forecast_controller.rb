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


    url = "https://api.forecast.io/forecast/463381d469fe2ca629ea884c9bfefaab/"+@lat+","+@lng
    parsed_data = JSON.parse(open(url).read)
    temp = parsed_data["currently"]["temperature"]
    summary = parsed_data["currently"]["summary"]
    sixty_min_summary = parsed_data["minutely"]["summary"]
    several_hour_summary = parsed_data["hourly"]["summary"]
    several_day_summary = parsed_data["daily"]["summary"]


    @current_temperature = temp

    @current_summary = summary

    @summary_of_next_sixty_minutes = sixty_min_summary

    @summary_of_next_several_hours = several_hour_summary

    @summary_of_next_several_days = several_day_summary

    render("coords_to_weather.html.erb")
  end
end
