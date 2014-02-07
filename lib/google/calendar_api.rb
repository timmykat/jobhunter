module Google
  class CalendarAPI
      
    def handle_response(response, request_params)
      case request_params['api_action']
        when 'create'
          event = ::Event.find(request_params['event_id'])
          event.google_event_id = response['id']
          event.save
      end
      response
    end
    
    def set_calendar
      build_request('get_calendar_id')
    end
    
    def create_event(event)
      build_request('create', event)
    end
    
    def update_event
      build_request('update', event)
    end
    
    def delete_event
      build_request('delete', event)
    end
    
    def find_event(search_terms)
      build_request('find', nil, search_terms)
    end

    def build_request(action, event_id = nil, search_terms = nil)
      auth = GoogleClient.first
      req = {
        :api => 'GoogleCalendar',
        :url_prefix => GOOGLE_CONFIG['google_calendar']['url_prefix'],
        :action => action
      }
      if action == 'get_calendar_id'
        req[:verb] =      'GET'
        req[:endpoint] =  "/users/me/calendarList"
        
      elsif !event_id.nil?
        event = ::Event.find(event_id)
        case action
          when 'create'
            event.google_calendar_id = auth.google_calendar_id
            req[:verb] =      'POST'
            req[:endpoint] =  "/calendars/#{auth.google_calendar_id}/events"
            req[:body] =    form_data(event)
 
          when 'update'
            req[:verb] =      'PUT'
            req[:endpoint] =  "/calendars/#{event.google_calendar_id}/events/#{event.google_event_id}"
            req[:body] =    form_data(event)
         
          when 'delete'
            req[:verb] =      'DELETE'
            req[:endpoint] =  "/calendars/#{event.google_calendar_id}/events/#{event.google_event_id}"         

          when 'find'
            event.google_calendar_id = auth.google_calendar_id
            req[:verb] =      'GET'
            req[:endpoint] =  "/calendars/#{auth.google_calendar_id}/events"
            req[:query] = ["q=#{CGI::escape(search_terms)}"]
        end
      else
        req = nil
      end
      req
    end
        
    def form_data(event)
      attendees = []
      attendees << {:displayName => 'Me', :email => GoogleClient.first.user_email }
      data = {
        :summary => "#{event.event_type} with #{event.opportunity.company}",
        :attendees => attendees,
        :start => { :dateTime => event.event_time.to_datetime.to_formatted_s(:rfc3339)},
        :end => { :dateTime => (event.event_time.to_datetime + 2.hours).to_formatted_s(:rfc3339)}
      }
      data[:id] = event.google_event_id if !event.google_event_id.blank?
      data 
    end
  end
end