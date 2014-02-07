# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
  $('#phone_interview, #site_interview').datetimepicker({
    format:'d.m.Y H:i',
    inline: true,
    lang: 'en'
  });
  
  $rejected = $('.rejected').remove()
  $('table tbody tr:last').after($rejected)
  $scheduled = $('.event-scheduled').remove()
  $('table tbody tr:first').before($scheduled)
