# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).ready ->
$(document).on 'turbolinks:load', ->
  $('[data-toggle="toggle"]').change ->
    $(this).parents().next('.hide').toggle()
    return

  $('.accordion-toggle').on 'click', ->
    $(this).find('i').toggleClass('fa-folder fa-folder-open')
