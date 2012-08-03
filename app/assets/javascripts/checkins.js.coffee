# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#locate").click (event) ->
    $("#locate").attr("disabled", "disabled")
    getLocation()
    
setAddress = (data) ->
  jQuery ->
    $("#address").val(data)
        
getLocation = () ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      lat = position.coords.latitude
      long = position.coords.longitude
      $.ajax '/locations/to_address',
        type: 'GET'
        dataType: 'text'
        data: {lat: lat, long: long}
        error: (jqXHR, textStatus, errorThrown) ->
          alert errorThrown
        success: (data, textStatus, jqXHR) ->
          setAddress(data)
          $("#locate").removeAttr('disabled')
        
      #$.get '/locations/to_address', {lat: lat, long: long}, setAddress, 'json'
    
