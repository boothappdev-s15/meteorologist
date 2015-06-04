require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
end

def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    parsed_data = JSON.parse(open("https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        parsed_data = JSON.parse(open("https://api.forecast.io/forecast/1e104cdbc43c2829e082503ded91477a/"+@latitude.to_s+","+@longitude.to_s).read)

      @current_temperature = parsed_data["currently"]["temperature"]

      @current_summary = parsed_data["currently"]["summary"]

      @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

      @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

      @summary_of_next_several_days = parsed_data["daily"]["summary"]

      render("street_to_weather.html.erb")
  end
end
