class GoogleClientController < ApplicationController
    
  def authenticate
    auth = request.env['omniauth.auth']
    client = GoogleClient.where("provider = ? AND uid = ?", auth[:provider], auth[:uid])
    if client.blank?
      client = GoogleClient.new(:provider => auth[:provider], :uid => auth[:uid], :identity => auth[:info][:name], :user_email => auth[:info][:email], :credentials => auth[:credentials] )
 
      if !client.save
        flash[:alert] = "Google authentication failed!"
      else
        flash[:notice] = "You were successfully authenticated with Google"
      
        # Set calendar
        client = GoogleClient.new.init
        req = client.calendar_api_build_request('get_calendar_id')
        if req.nil?
          flash[:alert] = "The Google calendar request was malformed"
        else
          response = client.send_request(req)
          response['items'].each do |calendar|
            if calendar['primary']
              client.google_calendar_id = calendar['id']
              client.save
              break
            end
          end
        end
      end
    end
    redirect_to '/'
  end
  
  def send_to_google
    client = GoogleClient.new.init
    request = client.send("#{params[:api]}_api_build_request", params[:api_action], params[:event_id])
    response = client.send_request(request)
    result = client.send("#{params[:api]}_api_handle_response", response, params)
    render :json => result
  end
      
  def disconnect
    GoogleClient.destroy_all
    redirect_to '/'
  end  
end