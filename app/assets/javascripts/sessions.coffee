$(document).ready ->
  if window.location.hash == '#_=_'
    if history.replaceState
      cleanHref = window.location.href.split('#')[0]
      history.replaceState null, null, cleanHref
    else
      window.location.hash = ''
