# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
  $('#states-table').tableDnD({
    onDrop: (table, row) ->
      data = {}
      weight = 0
      $('#states-table tr').each (index, element) ->
        if $(element).attr('id')
          id = $(element).attr('id').replace(/state-/, '');
          data[id] = index
      $.post('/ajax/states/update_order', data);
  })