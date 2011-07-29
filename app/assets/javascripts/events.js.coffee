# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(".event .actions a").live 'click', ->
  link = this
  $.ajax {
    url: this.href,
    type: 'get',
    success: (data) ->
      $(link).parents("li.event").replaceWith(data)
  }
  false

$(document).ready ->
	$(".event .tooltip").qtip {
    #position: {
    #  my: 'left center',
    #  at: 'right center'
    #},
    style: {
      classes: 'ui-tooltip-shadow ui-tooltip-youtube'
    }
  }
