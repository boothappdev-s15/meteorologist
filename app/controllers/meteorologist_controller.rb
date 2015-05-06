require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    target_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    raw_data = open(target_url).read
    data_hash = JSON.parse(raw_data)
    lat = data_hash["results"][0]["geometry"]["location"]["lat"]
    lng = data_hash["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/08c3bd7e8db7fd9577933d892b66797e/#{lat},#{lng}"
    weather_data = open(weather_url).read
    weather_hash = JSON.parse(weather_data)


    @current_temperature = weather_hash["currently"]["temperature"]

    @current_summary = weather_hash["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_hash["minutely"]["summary"]

    @summary_of_next_several_hours = weather_hash["hourly"]["summary"]

    @summary_of_next_several_days = weather_hash["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
