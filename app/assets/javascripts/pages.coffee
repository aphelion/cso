ready = ->
  $('a.page-scroll').bind 'click', (event) ->
    anchor = this.hash
    scrollPosition = if anchor.length > 0 then $(anchor).offset().top else 0
    $('body').stop().animate {scrollTop: scrollPosition}, 800
    event.preventDefault()

  $('.navbar').on 'click', (e) ->
    if $(e.target).is('a')
      $(e.target).closest('.navbar').find('.collapse.in').collapse 'hide'

$(document).ready(ready)
$(document).on('page:load', ready)
