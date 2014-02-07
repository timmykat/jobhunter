json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :company, :position, :phone_interview, :on_site_interview, :state_id
  json.url opportunity_url(opportunity, format: :json)
end
