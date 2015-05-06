require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # I haven't been able to get forecast_controller.rb to work, but here's how I would do this part: I would essentially combine the code for geocoding_controller and forecast_controller, except my outputs for geocoding_controller are going to be what go into my "url" below

    urla = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    parsed_data = JSON.parse(open(urla).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    #Then same code as for forecast_controller beginning at url_safe_lat but with @latitude and @longitude in the parenthesis#

    url_safe_lat = URI.encode(@latitude)
    url_safe_lng = URI.encode(@longitude)

    url = "https://api.forecast.io/forecast/ece023cb1d0d1c0ae59753eb0b8e94ee/" + url_safe_lat , url_safe_lng

    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
