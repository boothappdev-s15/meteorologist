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

    url_geo = "http://maps.googleapis.com/maps/api/geocode/json?address="+ url_safe_street_address
    parsed_data_geo = JSON.parse(open(url_geo).read)
    latitude = parsed_data_geo["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data_geo["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude

    @longitude = longitude

    url_weather = "https://api.forecast.io/forecast/463381d469fe2ca629ea884c9bfefaab/"+@latitude.to_s+","+@longitude.to_s
    parsed_data_weather = JSON.parse(open(url_weather).read)
    temp = parsed_data_weather["currently"]["temperature"]
    summary = parsed_data_weather["currently"]["summary"]
    sixty_min_summary = parsed_data_weather["minutely"]["summary"]
    several_hour_summary = parsed_data_weather["hourly"]["summary"]
    several_day_summary = parsed_data_weather["daily"]["summary"]

    @current_temperature = temp

    @current_summary = summary

    @summary_of_next_sixty_minutes = sixty_min_summary

    @summary_of_next_several_hours = several_hour_summary

    @summary_of_next_several_days = several_day_summary

    render("street_to_weather.html.erb")
  end
end
