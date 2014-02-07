json.array!(@recruiters) do |recruiter|
  json.extract! recruiter, :id, :company
  json.url recruiter_url(recruiter, format: :json)
end
