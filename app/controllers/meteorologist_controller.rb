require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @url = @street_address.gsub(/\s+/, "+")
    @gapi = "https://maps.googleapis.com/maps/api/geocode/json?address="+@url
    @parsed_data = JSON.parse(open(@gapi).read)
    @lat = @parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = @parsed_data["results"][0]["geometry"]["location"]["lng"]
    @gapi2 = "https://api.darksky.net/forecast/54505bbcb6ad201058bc5c29dbffecbc/"+@lat.to_s+','+@lng.to_s
    @parsed_data2 = JSON.parse(open(@gapi2).read)
    
    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================



    @current_temperature = @parsed_data2["currently"]["temperature"]

    @current_summary = @parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
