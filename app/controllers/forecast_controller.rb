require 'open-uri'
require 'json'

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

    url ="https://api.forecast.io/forecast/185b60e1409e8c7fc40446b654599afe/#{@lat},#{@lng}"

    parsed_data=JSON.parse(open(url).read) 

    @current_temperature =  parsed_data["currently"]["temperature"]
   
    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours  = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end

#parsed_data.keys
#["currently","minutely","hourly","daily","flags"]



   #parsed_data.keys

    # currently=parsed_data["currently"]

    # temp = currently["temperature"]

        #raw_data=open(url).read


    #url ="https://api.forecast.io/forecast/185b60e1409e8c7fc40446b654599afe/37.8627,-122.423"

#lat = URI.encode(@lat)
    #lng = URI.encode(@lng)