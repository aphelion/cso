@App ||= {}

App.cleanupLocationHash = ->
  # cleanup Facebook auth callback URL
  if window.location.hash == '#_=_'
    App.removeLocationHash()
  # cleanup Google auth callback URL
#  if window.location.hash == ''
#    App.removeLocationHash()

$(document).ready(App.cleanupLocationHash)
$(document).on('page:load', App.cleanupLocationHash)
