require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    @url = @street_address.gsub(/\s+/, "+")
    @gapi = "https://maps.googleapis.com/maps/api/geocode/json?address="+@url
    @parsed_data = JSON.parse(open(@gapi).read)
    # ==========================================================================
    # Your code goes below. Test2
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
