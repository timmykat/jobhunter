class GoogleClient < ActiveRecord::Base
  serialize :credentials
  validates :provider, uniqueness: true, inclusion: { in: %w(google_oauth2), message: "%{value} is not an allowed provider" }
  
  include RestClient
    
  def init
    client = GoogleClient.first
    if client.blank?
      flash[:notice] = "You must first authenticate with Google"
      redirect_to '/'
    end
    client
  end
  
  def method_missing method, *args, &block
    case
      when /^(.*)_api_build_request$/.match(method.to_s)
        api = "Google::#{$1.titlecase}API".constantize.new
        ret = api.build_request(args.first, args.second)
    when /^(.*)_api_handle_response$/.match(method.to_s)
        api = "Google::#{$1.titlecase}API".constantize.new
        ret = api.handle_response(args.first, args.second)
    end
    ret
  end

  def send_request(req)

    url = "#{req[:url_prefix]}#{req[:endpoint]}"
    if req[:query]
      url = "#{url}?#{req[:query].join('&')}"
    end
    
    headers = { :authorization => "Bearer #{self.credentials[:token]}", :accept => :json, :content_type => 'application/json' }

    # Add payload for post, patch, and put
    if %w/POST PATCH PUT/.include? req[:verb]
      payload = req[:body].to_json
      begin
        response = RestClient.send(req[:verb].downcase, url, payload, headers)
      rescue => e
        if e.response.code == 401
          self.get_new_access_token
          response = send_request(req)
        else
          ret = e.response
        end
      end
    else 
      begin
        response = RestClient.send(req[:verb].downcase, url, headers)
      rescue => e
        if e.response.code == 401
          self.get_new_access_token
          response = send_request(req)
        else
          ret = e.response
        end
      end      
    end

    if !response.code == 200
      flash[:error] = "Error #{response.code}: #{response.errors}"
      redirect_to '/'
    end
    response
  end
  
  def get_new_access_token
    data = {
      :refresh_token => self.credentials[:refresh_token],
      :client_id =>     GOOGLE_CONFIG['google_oauth2']['client_id'],
      :client_secret => GOOGLE_CONFIG['google_oauth2']['client_secret'],
      :grant_type =>    'refresh_token'
    }
    response = RestClient.post GOOGLE_CONFIG['google_oauth2']['token_url'], data, {:accept => :json}
    self.credentials[:token] = JSON.parse(response)['access_token']
    self.credentials[:expires_at] = Time.now + JSON.parse(response)['expires_in']
    self.save 
  end
end
