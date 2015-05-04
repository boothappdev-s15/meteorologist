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

    url = "https://api.forecast.io/forecast/9e12e5c5430628a4162d838a846225c8/#{@lat},#{@lng}"

    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]


    @nowtime = parsed_data["daily"]["data"][0]["time"]


    def future_forecast(now) #creates array of required dates
        day = 86400
        times = []
        1.upto(14) do |i|
            timenext = now + i*day
            times.push timenext
        end

        return times
    end


       @dates = future_forecast(@nowtime)

       def summaries(lat,lng,dates) #retrieves summaries for each of 14 dates

        summary_content = []
        dates.each do |date_number|

           url_weather_future = "https://api.forecast.io/forecast/9e12e5c5430628a4162d838a846225c8/#{lat},#{lng},#{date_number}"

           parsed_data_weather_future = JSON.parse(open(url_weather_future).read)

           day_summary = parsed_data_weather_future["daily"]["data"][0]["summary"]

           summary_content.push day_summary

       end

       return summary_content

        end


    @allsums = summaries(@lat,@lng,@dates)


    @day1 = @allsums[0]
    @day2 = @allsums[1]
    @day3 = @allsums[2]
    @day4 = @allsums[3]
    @day5 = @allsums[4]
    @day6 = @allsums[5]
    @day7 = @allsums[6]
    @day8 = @allsums[7]
    @day9 = @allsums[8]
    @day10 = @allsums[9]
    @day11= @allsums[10]
    @day12 = @allsums[11]
    @day13 = @allsums[12]
    @day14 = @allsums[13]

    render("coords_to_weather.html.erb")
  end
end
