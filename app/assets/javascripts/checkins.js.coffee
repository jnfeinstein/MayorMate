# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  
  $("#locate").click (event) ->
    getLocation()

getLocation = () ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      alert position.coords.latitude
    