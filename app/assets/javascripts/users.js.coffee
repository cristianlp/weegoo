# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(".user .actions a").live 'click', ->
  if (this.href.substr(this.href.length - 1) != "#")
    link = this
    $.ajax
      url: link.href,
      type: 'get',
      success: (data) ->
        $(link).parents("li.user").replaceWith(data)
  false

$(document).ready ->
  $(".user .tooltip").qtip {
    #position: {
    #  my: 'left center',
    #  at: 'right center'
    #},
    style: {
      classes: 'ui-tooltip-shadow ui-tooltip-youtube'
    }
  }
