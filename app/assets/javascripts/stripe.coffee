@App ||= {}
App.stripe ||= {}

App.setupFormUpdateOnInputChange = ->
  $('form[data-ticket-form] :input').on 'input change', ->
    form = $(this).closest('[data-ticket-form]')
    $.ajax
      type: 'post',
      url: form.attr('action') + '/calculate',
      data: form.serialize(),
      success: (partial) ->
        form.replaceWith($(partial))

$(document).ready(App.setupFormUpdateOnInputChange)
$(document).on('page:load', App.setupFormUpdateOnInputChange)
