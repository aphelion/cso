@App ||= {}

App.addAddon = (product_id, quantity) ->
  form = $('body').find('[data-ticket-form]')
  $.ajax
    type: 'post',
    url: form.attr('action') + '/calculate',
    data: form.serialize() + '&' + $.param({new_addon: {product_id: product_id, quantity: quantity}}),
    success: (partial) ->
      form.replaceWith($(partial))
