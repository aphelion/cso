@App ||= {}

App.addAddon = (product_id, quantity, product_choices) ->
  form = $('body').find('[data-ticket-form]')
  choices = {}
  for product_choice, i in product_choices
    choices[i] =  {option: product_choice.option, choice: product_choice.choice}

  $.ajax
    type: 'post',
    url: form.attr('action') + '/calculate',
    data: $('input[name!=_method]', form).serialize() + '&' + $.param({
      new_addon: {
        product_id: product_id,
        quantity: quantity,
        product_purchase_option_choices_attributes: choices
      }
    }),
    success: (partial) ->
      form.replaceWith($(partial))

App.removeAddon = (addon_index) ->
  $("[id^=event_purchase_addon_purchases_attributes_#{addon_index}_]").remove()
  App.updateEventPurchaseForm()

App.updateEventPurchaseForm = ->
  form = $('body').find('[data-ticket-form]')
  $.ajax
    type: 'post',
    url: form.attr('action') + '/calculate',
    data: $('input[name!=_method]', form).serialize(),
    success: (partial) ->
      form.replaceWith($(partial))

App.setupFormUpdateOnInputChange = ->
  $('form[data-ticket-form] [data-ticket-form-update]').on 'input change', ->
    App.updateEventPurchaseForm()

$(document).ready(App.setupFormUpdateOnInputChange)
$(document).on('page:load', App.setupFormUpdateOnInputChange)
