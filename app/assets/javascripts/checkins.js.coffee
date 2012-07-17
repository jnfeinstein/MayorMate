# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#locate").click (event) ->
  alert "SUP!"

getLocation = () ->

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      
    $watchid = null

    startFollowing = -> 
      alert "Following you!"
      $watchID = navigator.geolocation.watchPosition (position) ->
        showLocation(position.coords.latitude, position.coords.longitude)

    stopFollowing = ->
      alert "Stopped following you!"
      navigator.geolocation.clearWatch(watchID)