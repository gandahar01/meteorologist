require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]
    @gapi2 = "https://api.darksky.net/forecast/54505bbcb6ad201058bc5c29dbffecbc/"+@lat+','+@lng
    @parsed_data2 = JSON.parse(open(@gapi2).read)

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================



    @current_temperature = @parsed_data2["currently"]["temperature"]

    @current_summary = @parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data2["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
