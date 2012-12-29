$ = jQuery

$ ->
  $(".wrong").on 'click', ( e ) ->
    e.preventDefault()
    $(".description").hide().fadeIn()
