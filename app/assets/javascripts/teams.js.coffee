# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $("#team_hospital_id").select2
    width: "100%"
    placeholder: "Type a character"
    placeholderOption: "first"
    allowClear: true
    minimunInputLength: 1

 $("#team_member_ids").select2
    width: "100%"
    placeholder: "Type a character"
    placeholderOption: "first"
    allowClear: true
    minimunInputLength: 1
