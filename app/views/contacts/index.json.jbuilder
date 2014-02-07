json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :title, :email, :phone, :last_contact, :opportunity_id, :recruiter_id
  json.url contact_url(contact, format: :json)
end
