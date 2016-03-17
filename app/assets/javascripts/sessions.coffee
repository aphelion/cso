ready = ->
  # cleanup Facebook auth callback URL
  if window.location.hash == '#_=_'
    App.removeLocationHash()
  # cleanup Google auth callback URL
#  if window.location.hash == ''
#    App.removeLocationHash()

$(document).ready(ready)
$(document).on('page:load', ready)
