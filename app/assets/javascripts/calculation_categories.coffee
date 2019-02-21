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

  $('.collapse-all').on 'click', (e) ->
    #e.prevenDeffault()
    e.stopImmediatePropagation()
    $('.collapse').collapse('hide');
    #$('.accordion').find('.accordion-toggle i').toggleClass('fa-folder fa-folder-open')
    $('.accordion').find('.accordion-toggle i').addClass('fa-folder')
    $('.accordion').find('.accordion-toggle i').removeClass('fa-folder-open')


  $('.expand-all').on 'click', (e) ->
    #e.prevenDeffault()
    e.stopImmediatePropagation()
    $('.collapse').collapse('show');
    #$('.accordion').find('.accordion-toggle i').toggleClass('fa-folder fa-folder-open')
    $('.accordion').find('.accordion-toggle i').addClass('fa-folder-open')
    $('.accordion').find('.accordion-toggle i').removeClass('fa-folder')
