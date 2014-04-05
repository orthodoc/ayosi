# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.datepicker')
    .datepicker
      format: "MM dd, yyyy"
      todayHighlight: true

  $('#patient_age')
    .select2
      width: "100%"

  $('#patient_hospital_id')
    .select2
      width: "100%"
      placeholder: "Select the hospital"

  $('#patient_surgeon')
    .select2
      width: "100%"
      placeholder: "Select the surgeon"
