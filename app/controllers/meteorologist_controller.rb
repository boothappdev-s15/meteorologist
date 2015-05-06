require 'open-uri'

class MeteorologistController < ApplicationController

  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # @time = Time.new.to_i




    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    url= "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    parsed_data= JSON.parse(open(url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    # Basic Information from API
    url_w= "https://api.forecast.io/forecast/89e6594b48fb0682af6be2fc920e272d/" + @latitude.to_s + ',' + @longitude.to_s

    parsed_data_w=JSON.parse(open(url_w).read)

    # Time Information from the API

    @day= Array.new
    @time= Array.new
    url_t= Array.new
    parsed_data_t=Array.new
    @summary_day_one=Array.new
    n=0
    while n < 14
        @time[n]=Time.now.to_i +  (n+1).day
    url_t[n] ="https://api.forecast.io/forecast/89e6594b48fb0682af6be2fc920e272d/" + @latitude.to_s + ',' + @longitude.to_s + ',' + @time[n].to_s
    parsed_data_t[n]=JSON.parse(open(url_t[n]).read)
    @summary_day_one[n] = parsed_data_t[n]["daily"]["data"][0]["temperatureMax"]
    @day[n]= (Time.now + (n+1).day).strftime("%A")
    n=n+1
end

    @current_temperature = parsed_data_w["currently"]["temperature"]

    @current_temperature_max= parsed_data_w["daily"]["data"][0]["temperatureMax"]

    @current_temperature_min= parsed_data_w["daily"]["data"][0]["temperatureMin"]

    @current_summary = parsed_data_w["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_w["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_w["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_w["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
