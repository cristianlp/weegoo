# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

updateSubCategory = (category_id, sub_category_id, selected_sub_category) ->
  url = "/update_sub_categories/" + ($(category_id).val() or -1)
  $(sub_category_id).find("option").remove().end()
  
  $.get url, (data) ->
    $.each $.parseJSON(data), (key, value) ->
      selected_attr = (selected_sub_category == undefined || selected_sub_category != value.id) ? "" : " selected=\"selected\""
      $(sub_category_id).append("<option value=\""+value.id+"\""+selected_attr+">"+value.name+"</option>")

# change event for venue form
$("#venue_category_id").live 'change', ->
  updateSubCategory("#venue_category_id", "#venue_sub_category_id")

$(window).load ->
  if ($("#venue_sub_category_id").val() != undefined)
    selected_sub_category = $("#venue_sub_category_id").val()
    updateSubCategory "#venue_category_id", "#venue_sub_category_id", selected_sub_category

$(".venue .actions a").live 'click', ->
  link = this
  $.ajax {
    url: this.href,
    type: 'get',
    success: (data) ->
      $(link).parents("li.venue").replaceWith(data)
  }
  false