# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
  $('body table').on('click', 'a.unsynced', (e) ->
    e.preventDefault();
    eventId = $(e.currentTarget).attr('id').replace('event-', '')
    $.post('ajax/google/send', {"api": "calendar", "api_action": "create", "event_id": eventId }, (data) ->
      $('#flash').append("<div class='flash notice'>" + data.summary + " added to your Google calendar</div>");
      $("a#event-" + eventId).removeClass('unsynced').addClass('synced').text("N Sync");
    );
  );
