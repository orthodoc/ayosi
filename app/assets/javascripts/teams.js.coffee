# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#team_hospital_id")
    .select2
      width: "100%"
      placeholder: "Select a hospital"
      allowClear: true
    .on "change", ->
      hospital_id = $("#team_hospital_id").select2("val")
      $("#team_member_list")
        .select2
          width: "100%"
          allowClear: true
          multiple: true
          separator: ","
          ajax:
            url: Routes.hospital_users_path(hospital_id)
            dataType: "json"
            quietMillis: 100
            results: (data, page) ->
              results: data
          formatSelection: (item) ->
            item.name
          formatResult: (item) ->
            item.name

  $("#team_member_list")
    .select2
      width: "100%"
      allowClear: true
      multiple: true
      separator: ","
      ajax:
        dataType: "json"
        quietMillis: 100
        results: (data, page) ->
          results: data
      formatSelection: (item) ->
        item.name
      formatResult: (item) ->
        item.name
