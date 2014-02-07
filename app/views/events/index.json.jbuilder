json.array!(@events) do |event|
  json.extract! event, :id, :event_type, :event_time, :opportunity_id, :recruiter_id
  json.url event_url(event, format: :json)
end
