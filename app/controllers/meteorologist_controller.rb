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

       url_coord = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}&"


    parsed_data_coord = JSON.parse(open(url_coord).read)

    @lat = parsed_data_coord["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data_coord["results"][0]["geometry"]["location"]["lng"]

    url_weather = "https://api.forecast.io/forecast/9e12e5c5430628a4162d838a846225c8/#{@lat},#{@lng}"

    parsed_data_weather = JSON.parse(open(url_weather).read)


    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    # trying to avoid error if location has no minutely data:
    #
    # def skip_error(weather_minutes)
    #     if weather_minutes["minutely"]["summary"] == nil
    #         return "Unavailable"
    #     else
    #         return weather_minutes["minutely"]["summary"]
    #     end
    # end

    # @summary_min_no_error = skip_error(@parsed_data_weather)

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]


    # Over next 14 days
    # each day is 86400 more in unix


    @nowtime = parsed_data_weather["daily"]["data"][0]["time"]


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



    render("street_to_weather.html.erb")
  end
end
