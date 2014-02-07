module Google
  class ContactsAPI
  
    def handle_response(response)
      binding.pry
    end

    def build_request(action, contact)      
      req = {
        :api => 'GoogleContacts',
        :url_prefix => GOOGLE_CONFIG['google_contacts']['url_prefix'],
        :action => action
      }
      case action
        when 'create'
          req[:verb] =      'POST'
          req[:endpoint] =  "/#{@auth.email}/full"
          req[:params] =    form_data(contact)

        when 'update'
          req[:verb] =      'PUT'
          req[:endpoint] =  "/#{@auth.email}/full/#{google_contact_id}"
          req[:params] =    form_data(contact)
    
        when 'delete'
          req[:verb] =      'DELETE'
          req[:endpoint] =  "/#{@auth.email}/full/#{google_contact_id}"         
      end
      req
    end
    
    def form_data(contact)
      data = "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gd='http://schemas.google.com/g/2005'>\n"
      if contact.name
        data += add_element(:name, [{ :type => 'fullName', :text => contact.name }])
      end
      if contact.opportunity
        data += add_element(:organization, contact.opportunity.name )
      end
      if contact.email
        data += add_element(:email,contact.email )
      end
      if contact.phone
        data += add_element(:phoneNumber, contact.phone )
      end
      data += "</entry>"
    end
    
    def add_element(element, *args)
      text = "  <gd:#{element.to_s}>\n"
      if args.first.is_a? String
        text += args.first
      else
        args.each do |item|
          text += "    <gd:#{item[:type]} rel='http://schemas.google.com/g/2005#work'>\n#{item[:text]}<gd:#{item[:type]}>\n"
        end
      end
      text += "  <gd:#{element.to_s}>\n"
    end
  end
end