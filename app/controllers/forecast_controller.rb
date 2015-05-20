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

    url_w= "https://api.forecast.io/forecast/89e6594b48fb0682af6be2fc920e272d/" + @lat + ',' + @lng
    parsed_data_w=JSON.parse(open(url_w).read)


    @current_temperature = parsed_data_w["currently"]["temperature"]

    @current_summary = parsed_data_w["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_w["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_w["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_w["daily"]["summary"]


    render("coords_to_weather.html.erb")
  end
end
