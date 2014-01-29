# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#designation_hospital_id").select2(
    width: "resolve"
    placeholder: "Type a character"
    placeholderOption: "first"
    allowClear: true
    minimunInputLength: 1
  )
