# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#patient_age")
    .select2
      width: "100%"
      allowClear: true

  $("#patient_birthday")
    .fdatepicker
      format: 'MM dd, yyyy'
      viewMode: "2"
      minViewMode: "2"
    .on "changeDate", ->
      dateString = $("patient_birthday").fdatepicker("val")

  $("#patient_hospital_id")
    .select2
      width: "100%"
      placeholder: "Select a hospital"
      allowClear: true
