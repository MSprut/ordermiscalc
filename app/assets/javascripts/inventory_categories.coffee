# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $ ->
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr 'title', 'Свернуть ветку'
  
  $('.tree li.parent_li > span').on 'click', (e) ->
    children = $(this).parent('li.parent_li').find ' > ul > li'
    if children.is ":visible"
      children.hide 'fast'
      $(this).attr('title', 'Развернуть ветку').find(' > i').addClass('fa-plus-square-o').removeClass 'fa-minus-square-o'
    else
      children.show 'fast'
      $(this).attr('title', 'Свернуть ветку').find(' > i').addClass('fa-minus-square-o').removeClass 'fa-plus-square-o'
    e.stopPropagation()
