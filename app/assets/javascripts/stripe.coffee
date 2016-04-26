@App ||= {}
App.stripe ||= {}

App.updateEventPurchaseForm = ->
  form = $('body').find('[data-ticket-form]')
  $.ajax
    type: 'post',
    url: form.attr('action') + '/calculate',
    data: form.serialize(),
    success: (partial) ->
      form.replaceWith($(partial))  

App.setupFormUpdateOnInputChange = ->
  $('form[data-ticket-form] [data-ticket-form-update]').on 'input change', ->
    App.updateEventPurchaseForm()

$(document).ready(App.setupFormUpdateOnInputChange)
$(document).on('page:load', App.setupFormUpdateOnInputChange)
