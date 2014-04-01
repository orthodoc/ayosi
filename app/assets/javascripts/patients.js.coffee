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
      today = new Date()
      birthDate = $("patient_birthday").fdatepicker.getDate
      age = today.getYear() - birthDate.getYear()
      m = today.getMonth() - birthDate.getMonth()
      age-- if m < 0 or (m is 0 and today.getDate() < birthDate.getDate())
      $("patient_age").select2("val", age)
      console.log(birthDate)

  $("#patient_hospital_id")
    .select2
      width: "100%"
      placeholder: "Select a hospital"
      allowClear: true

  $("#patient_surgeon")
    .select2
      width: "100%"
      placeholder: "Select a surgeon's name"
      allowClear: true
