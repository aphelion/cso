ready = ->
  # scroll to sections only on homepage
  if window.location.pathname == '/'
    $('a.page-scroll').bind 'click', (event) ->
      anchor = this.hash
      scrollPosition = if anchor.length > 0 then $(anchor).offset().top else 0
      $('body').stop().animate {scrollTop: scrollPosition}, 800
      event.preventDefault()
  # remove anchors in the URL on the homepage
  if window.location.pathname == '/'
    App.removeLocationHash()

  # close the collapsed navbar when a user clicks any link
  $('.navbar').on 'click', (e) ->
    if $(e.target).is('a')
      $(e.target).closest('.navbar').find('.collapse.in').collapse 'hide'

$(document).ready(ready)
$(document).on('page:load', ready)
