require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]
    url = "https://api.forecast.io/forecast/08c3bd7e8db7fd9577933d892b66797e/#{@lat},#{@lng}"
    raw_data = open(url).read
    data_hash = JSON.parse(raw_data)


    @current_temperature = data_hash["currently"]["temperature"]

    @current_summary = data_hash["currently"]["summary"]

    @summary_of_next_sixty_minutes = data_hash["minutely"]["summary"]

    @summary_of_next_several_hours = data_hash["hourly"]["summary"]

    @summary_of_next_several_days = data_hash["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
