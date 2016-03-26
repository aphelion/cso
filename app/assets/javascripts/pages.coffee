App.jumpToOffsetAnchor = ->
  navHeightClosed = $('nav').outerHeight()
  anchor = window.location.hash
  scrollPosition = if anchor.length > 0 then $(anchor).offset().top - navHeightClosed else 0
  $('body').scrollTop(scrollPosition)

App.setupHomepageScroll = ->
  navHeightClosed = $('nav').outerHeight()
  # scroll to sections only on homepage
  if window.location.pathname == '/'
    $('a.page-scroll').bind 'click', (event) ->
      anchor = this.hash
      scrollPosition = if anchor.length > 0 then $(anchor).offset().top - navHeightClosed else 0
      $('body').stop().animate {scrollTop: scrollPosition}, 800
      event.preventDefault()
  # remove anchors in the URL on the homepage
  if window.location.pathname == '/'
    App.jumpToOffsetAnchor()
    App.removeLocationHash()

  # close the collapsed navbar when a user clicks any link
  $('.navbar').on 'click', (e) ->
    if $(e.target).is('a')
      $(e.target).closest('.navbar').find('.collapse.in').collapse 'hide'

$(document).ready(App.setupHomepageScroll)
$(document).on('page:load', App.setupHomepageScroll)
